//
//  PlainTextRequestTests.swift
//  APIKitTests
//

import XCTest

class PlainTextRequestTests: XCTestCase {

    func test_GivenRequest_WhenUrlRequest_ThenRequestIsFilled() throws {
        let request = MockPlainTextGetRequest()
        let urlRequest = try XCTUnwrap(request.urlRequest)

        let contentType = try XCTUnwrap(urlRequest.allHTTPHeaderFields?["Content-Type"])
        XCTAssertEqual(contentType, "text/plain")
    }

}
