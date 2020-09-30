//
//  TestURLSession.swift
//  APIKitTests
//

import Foundation

class TestURLSessionDataTask: URLSessionDataTask {
    private let perform: () -> Void

    init(perform: @escaping () -> Void) {
        self.perform = perform
    }

    override func resume() {
        perform()
    }
}

class TestURLSession: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        return TestURLSessionDataTask {
            completionHandler(data, response, error)
        }
    }
}
