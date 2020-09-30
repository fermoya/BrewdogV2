//
//  BeersGetRequest.swift
//  APIKit
//

import Foundation

public struct BeersGetRequest: JSONGetRequest {
    public typealias ResponseType = [Beer]

    public var queryParameters: HTTPQueryParameters {
        [
            "page": "\(page)"
        ]
    }
    public let host: HTTPHost = .punkApi
    public let path: String = "/v2/beers"

    public let page: Int

    public init(page: Int = 1) {
        self.page = page
    }
}
