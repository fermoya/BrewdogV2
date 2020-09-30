//
//  ChallengeGetRequest.swift
//  APIKit
//

import Foundation

public struct ChallengeGetRequest: PlainTextGetRequest {
    public var queryParameters: HTTPQueryParameters = .empty
    public var host: HTTPHost = .breweryProblem
    public let path: String = "/LuigiPapinoDrop/d8ed153d5431bbad23e1e1c6b5ba1e3c/raw/4ec1c8064e51838240e941679d3ac063460685c2/code_challenge_richer.txt"

    public init() { }
}
