//
//  GetRequestTests.swift
//  APIKitTests
//

import XCTest
@testable import APIKit

class GetRequestTests: XCTestCase {

    func test_GivenRequest_WhenUrlRequest_ThenRequestIsFilled() throws {
        let request = MockGetRequest()
        let urlRequest = try XCTUnwrap(request.urlRequest)
        let url = try XCTUnwrap(urlRequest.url)

        let components = try XCTUnwrap(URLComponents(string: url.absoluteString))
        let queryValue = try XCTUnwrap(components.queryItems?.first { $0.name == "queryItem" }?.value)
        let headerValue = try XCTUnwrap(urlRequest.allHTTPHeaderFields?["header"])
        let host = try XCTUnwrap(components.host)
        let scheme = try XCTUnwrap(components.scheme)

        XCTAssertEqual(components.path, request.path)
        XCTAssertEqual("\(scheme)://\(host)", request.host.rawValue)
        XCTAssertEqual(queryValue, "queryValue")
        XCTAssertEqual(headerValue, "headerValue")
    }

}
