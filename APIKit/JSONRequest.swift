//
//  JSONRequest.swift
//  APIKit
//

import Foundation

public typealias JSONGetRequest = JSONRequest & GetRequest

public protocol JSONRequest: GetRequest {
    associatedtype ResponseType: Decodable
}

extension JSONRequest {
    
    public var headers: HTTPHeaders {
        ["Content-Type": "application/json"]
    }
}
