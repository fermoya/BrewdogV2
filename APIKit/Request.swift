//
//  Request.swift
//  APIKit
//

import Foundation

public enum HTTPHost: String {
    case punkApi = "https://api.punkapi.com"
    case breweryProblem = "https://gist.githubusercontent.com"
}

public enum HTTPMethod: String {
    case get = "GET"
}

public protocol Request {

    typealias HTTPHeaders = [String: String]

    var host: HTTPHost { get }
    var headers: HTTPHeaders { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var urlRequest: URLRequest? { get }
}
