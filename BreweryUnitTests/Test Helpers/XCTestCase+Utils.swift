//
//  XCTestCase+Utils.swift
//  BreweryUnitTests
//

import XCTest

extension XCTestCase {
    func data(from fileName: String, withFormat format: String = "json" ) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: format) else {
            XCTFail("Missing file: \(fileName).\(format)")
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
