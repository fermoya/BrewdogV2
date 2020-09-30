//
//  Array+Utils.swift
//  Brewery
//

import Foundation

extension Array {
    func filteringEvenPositions() -> Self {
        return self.enumerated()
            .filter { $0.offset.isEven }
            .map { $0.element }
    }

    func filteringOddPositions() -> Self {
        return self.enumerated()
            .filter { $0.offset.isOdd }
            .map { $0.element }
    }
}
