//
//  APIKitTests.swift
//  APIKitTests
//

import XCTest
@testable import APIKit

class BeersGetRequestTests: XCTestCase {

    func test_GivenRequest_WhenPath_ThenExpectedResult() {
        let request = BeersGetRequest()
        let path = request.path
        XCTAssertEqual(path, "/v2/beers")
    }

    func test_GivenRequest_WhenHost_ThenExpectedPunkApi() {
        let request = BeersGetRequest()
        let host = request.host
        XCTAssertEqual(host, .punkApi)
    }

    func test_GivenRequest_WhenQueryParameters_ThenPage1() throws {
        let request = BeersGetRequest()
        let queryParameters = request.queryParameters
        let page = try XCTUnwrap(queryParameters["page"])
        XCTAssertEqual(page, "1")
    }

    func test_GivenRequestPage2_WhenQueryParameters_ThenPage2() throws {
        let request = BeersGetRequest(page: 2)
        let queryParameters = request.queryParameters
        let page = try XCTUnwrap(queryParameters["page"])
        XCTAssertEqual(page, "2")
    }

}
