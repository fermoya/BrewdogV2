//
//  GetRequest.swift
//  APIKit
//

import Foundation

extension Dictionary {
    static var empty: Self { return [:] }
}

public protocol GetRequest: Request {
    typealias HTTPQueryParameters = [String: String]
    var queryParameters: HTTPQueryParameters { get }
}

extension GetRequest {
    public var httpMethod: HTTPMethod { return .get  }
    public var urlRequest: URLRequest? {
        let appendix = queryParameters.reduce("?") { total, item in
            return total == "?" ? "\(total)\(item.key)=\(item.value)" : "\(total)&\(item.key)=\(item.value)"
        }
        let urlString = host.rawValue + path + appendix
        guard let url = URL(string: urlString) else { return nil }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = httpMethod.rawValue
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
}
