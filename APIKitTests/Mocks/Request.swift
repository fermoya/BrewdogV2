//
//  MockGetRequest.swift
//  APIKitTests
//

import Foundation
@testable import APIKit

struct MockType: Decodable {
    var id: Int
    var name: String
}

struct MockBadFormedGetRequest: JSONGetRequest {
    typealias ResponseType = MockType?
    var queryParameters: HTTPQueryParameters = ["queryItem": "queryValue"]
    var host: HTTPHost = .punkApi
    let headers: HTTPHeaders = ["header": "headerValue"]
    let path: String = "/ path"
}

struct MockGetRequest: JSONGetRequest {
    typealias ResponseType = MockType?
    var queryParameters: HTTPQueryParameters = ["queryItem": "queryValue"]
    var host: HTTPHost = .punkApi
    let headers: HTTPHeaders = ["header": "headerValue"]
    let path: String = "/path"
}

struct MockJSONGetRequest: JSONGetRequest {
    typealias ResponseType = MockType?
    let queryParameters: HTTPQueryParameters = ["queryItem": "queryValue"]
    var host: HTTPHost = .punkApi
    let path: String = "/path"
}

struct MockPlainTextGetRequest: PlainTextGetRequest {
    let queryParameters: HTTPQueryParameters = .empty
    let host: HTTPHost = .breweryProblem
    let path: String = "/path"
}
