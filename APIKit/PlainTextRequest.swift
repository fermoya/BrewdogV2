//
//  PlainRequest.swift
//  APIKit
//

import Foundation

public typealias PlainTextGetRequest = PlainTextRequest & GetRequest

public protocol PlainTextRequest: GetRequest { }

extension PlainTextRequest {

    public var headers: HTTPHeaders {
        ["Content-Type": "text/plain"]
    }
}
