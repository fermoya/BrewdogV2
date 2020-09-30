//
//  JSONRequestTests.swift
//  APIKitTests
//

import XCTest
@testable import APIKit

class JSONRequestTests: XCTestCase {

    func test_GivenRequest_WhenUrlRequest_ThenRequestIsFilled() throws {
        let request = MockJSONGetRequest()
        let urlRequest = try XCTUnwrap(request.urlRequest)

        let contentType = try XCTUnwrap(urlRequest.allHTTPHeaderFields?["Content-Type"])
        XCTAssertEqual(contentType, "application/json")
    }

}

