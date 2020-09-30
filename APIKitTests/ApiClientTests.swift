//
//  ApiClientTests.swift
//  APIKitTests
//

import XCTest
import Combine
@testable import APIKit

class ApiClientTests: XCTestCase {

    private var disposeBag: Set<AnyCancellable> = .init()

    func test_GivenSuccessClient_WhenSend_ThenDecodeResponse() {
        let expectation = self.expectation(description: "Decoded response expected")
        var result: MockType?

        let request = MockGetRequest()
        let client = ApiClient(session: successfulSession)
        client.send(request)
            .jsonPublisher()
            .replaceError(with: nil)
            .sink { response in
                result = response
                expectation.fulfill()
            }
            .store(in: &disposeBag)

        waitForExpectations(timeout: 1)
        XCTAssertNotNil(result)
    }

    func test_GivenDecodingFailureClient_WhenSend_ThenDecodeResponse() throws {
        let expectation = self.expectation(description: "Decoded error expected")
        var error: ApiClientError?

        let request = MockGetRequest()
        let client = ApiClient(session: decodingFailureSession)
        client.send(request)
            .jsonPublisher()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let resultError):
                    error = resultError
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { _ in })
            .store(in: &disposeBag)

        waitForExpectations(timeout: 1)
        let result = try XCTUnwrap(error)
        XCTAssertTrue(result.equalsIgnoreValues(.decodingError))
    }

    func test_GivenNoInternetClient_WhenSend_ThenUnknownError() throws {
        let expectation = self.expectation(description: "Unknown error expected")
        var error: ApiClientError?

        let request = MockGetRequest()
        let client = ApiClient(session: urlErrorSession)
        client.send(request)
            .jsonPublisher()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let resultError):
                    error = resultError
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { _ in })
            .store(in: &disposeBag)

        waitForExpectations(timeout: 1)
        let result = try XCTUnwrap(error)
        XCTAssertTrue(result.equalsIgnoreValues(.unknown))
    }

    func test_GivenBadRequestSession_WhenSend_ThenUnknownError() throws {
        let expectation = self.expectation(description: "Bad Request error expected")
        var error: ApiClientError?

        let request = MockGetRequest()
        let client = ApiClient(session: badRequestSession)
        client.send(request)
            .jsonPublisher()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let resultError):
                    error = resultError
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { _ in })
            .store(in: &disposeBag)

        waitForExpectations(timeout: 1)
        let result = try XCTUnwrap(error)
        XCTAssertTrue(result.equalsIgnoreValues(.badRequest))
    }

    func test_GivenBadRequestSession_WhenSend_ThenUrlMalFormed() throws {
        let expectation = self.expectation(description: "Url malformed error expected")
        var error: ApiClientError?

        let request = MockBadFormedGetRequest()
        let client = ApiClient(session: successfulSession)
        client.send(request)
            .jsonPublisher()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let resultError):
                    error = resultError
                case .finished:
                    break
                }
                expectation.fulfill()
            }, receiveValue: { _ in })
            .store(in: &disposeBag)

        waitForExpectations(timeout: 1)
        let result = try XCTUnwrap(error)
        XCTAssertTrue(result.equalsIgnoreValues(.urlMalFormmed))
    }

    func test_GivenSuccessClient_WhenSend_ThenPlainText() throws {
        let expectation = self.expectation(description: "Plain Text expected")
        var result: String?

        let request = MockGetRequest()
        let client = ApiClient(session: successfulPlainTextSession)
        client.send(request)
            .plainText()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in
                    result = response
                    expectation.fulfill()
                  })
            .store(in: &disposeBag)

        waitForExpectations(timeout: 1)
        XCTAssertEqual(result, plainText)
    }

}

extension ApiClientError {

    static let unknown: Self = .unknown("")

    static let decodingError: Self = .decodingError(.dataCorrupted(.init(codingPath: [], debugDescription: "")))

    func equalsIgnoreValues(_ other: Self) -> Bool {
        switch (self, other) {
        case (.decodingError, .decodingError),
             (.urlMalFormmed, .urlMalFormmed),
             (.badRequest, .badRequest),
             (.unauthorized, .unauthorized),
             (.forbidden, .forbidden),
             (.notFound, .notFound),
             (.internalServerError, .internalServerError),
             (.badGateway, .badGateway),
             (.unavailable, .unavailable),
             (.unknown, .unknown):
            return true
        default:
            return false
        }
    }

}

extension ApiClientTests {

    private var successfulData: Data! {
        """
        {
            "id": 1,
            "name": "Guiness"
        }
        """.data(using: .utf8)
    }

    private var plainText: String { "This is a test" }

    private var badFormattedData: Data! {
        """
        {
            "id": "1",
            "name": "Guiness"
        }
        """.data(using: .utf8)
    }

    private var badRequestSession: URLSession {
        let session = TestURLSession()
        session.data = successfulData
        session.response = HTTPURLResponse(url: URL(string: "http://www.example.com")!,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: nil)
        return session
    }

    private var urlErrorSession: URLSession {
        let session = TestURLSession()
        session.error = URLError(.notConnectedToInternet)
        session.response = HTTPURLResponse(url: URL(string: "http://www.example.com")!,
                                           statusCode: -1,
                                           httpVersion: nil,
                                           headerFields: nil)
        return session
    }

    private var decodingFailureSession: URLSession {
        let session = TestURLSession()
        session.data = badFormattedData
        session.response = HTTPURLResponse(url: URL(string: "http://www.example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
        return session
    }

    private var successfulSession: URLSession {
        let session = TestURLSession()
        session.data = successfulData
        session.response = HTTPURLResponse(url: URL(string: "http://www.example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
        return session
    }

    private var successfulPlainTextSession: URLSession {
        let session = TestURLSession()
        session.data = plainText.data(using: .utf8)
        session.response = HTTPURLResponse(url: URL(string: "http://www.example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
        return session
    }

}
