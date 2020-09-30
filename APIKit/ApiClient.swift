//
//  ApiClient.swift
//  APIKit
//

import Foundation
import Combine

public enum ApiClientError: Error {
    case decodingError(DecodingError)
    case urlMalFormmed
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case badGateway
    case unavailable
    case unknown(String)
}

public protocol Webservice {
    var session: URLSession { get }
    init(session: URLSession)
}

public class WebserviceTask<T> where T: Request {

    var session: URLSession
    var request: T

    init(session: URLSession, request: T) {
        self.session = session
        self.request = request
    }

    private func publisher<R>(type: R.Type, decode: @escaping (Data) throws -> R) -> AnyPublisher<R, ApiClientError> {

        guard let urlRequest = request.urlRequest else {
            return Fail(error: ApiClientError.urlMalFormmed).eraseToAnyPublisher()
        }

        return session
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> R in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw ApiClientError.unknown("No HTTP response")
                }

                guard 200..<300 ~= httpResponse.statusCode else {
                    let error = self.mapHTTPError(with: httpResponse.statusCode)
                    throw error
                }

                return try decode(data)
            }
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .mapError {
                guard let error = $0 as? ApiClientError else {
                    return ApiClientError.unknown($0.localizedDescription)
                }
                return error
            }
            .eraseToAnyPublisher()
    }

    public func plainText() -> AnyPublisher<String, ApiClientError> {
        publisher(type: String.self) { data in
            guard let string = String(data: data, encoding: .utf8) else {
                throw ApiClientError.unknown("Couldn't convert response into String")
            }
            return string
        }
    }

    private func mapHTTPError(with code: Int) -> ApiClientError {
        let error: ApiClientError
        switch code {
        case 400:
            error = .badRequest
        case 401:
            error = .unauthorized
        case 403:
            error = .forbidden
        case 404:
            error = .notFound
        case 500:
            error = .internalServerError
        case 502:
            error = .badGateway
        case 503:
            error = .unavailable
        default:
            error = .unknown("HTTP code \(code)")
        }
        return error
    }
}

extension Webservice {
    public func send<T: Request>(_ request: T) -> WebserviceTask<T> {
        WebserviceTask(session: session, request: request)
    }
}

public class ApiClient: Webservice {

    public let session: URLSession

    required public init(session: URLSession = URLSession.shared) {
        self.session = session
    }

}

extension WebserviceTask where T: JSONRequest {

    public func jsonPublisher() -> AnyPublisher<T.ResponseType, ApiClientError> {
        publisher(type: T.ResponseType.self) { (data) in
            do {
                let result = try JSONDecoder().decode(T.ResponseType.self, from: data)
                return result
            } catch let error as DecodingError {
                throw ApiClientError.decodingError(error)
            } catch let error {
                throw ApiClientError.unknown(error.localizedDescription)
            }
        }
    }

}
