//
//  MockApiClient.swift
//  BreweryUnitTests
//

import APIKit

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

class MockApiClient: Webservice {

    let session: URLSession = TestURLSession()

    required init(session: URLSession) {
        fatalError("Use init(data:,error:) instead")
    }

    init(data: Data?, error: Error?, httpStatusCode: Int) {
        (session as? TestURLSession)?.data = data
        (session as? TestURLSession)?.error = error
        (session as? TestURLSession)?.response = HTTPURLResponse(url: URL(string: "http://www.example.com")!,
                                                                 statusCode: httpStatusCode,
                                                                 httpVersion: nil,
                                                                 headerFields: nil)
    }

}
