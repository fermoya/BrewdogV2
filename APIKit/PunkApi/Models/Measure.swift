//
//  Amount.swift
//  Domain
//

import Foundation

public enum MeasureType: String {
    case grams, kilograms, litres, celsius, none = ""
}

public struct Measure: Decodable {
    public var value: Float?
    public var measureType: MeasureType

    private enum CodingKeys: String, CodingKey {
        case value
        case measureType = "unit"
    }

    public init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let value = try? container.decode(Float.self, forKey: .value)
        let measureType = try! container.decode(String.self, forKey: .measureType)

        self.init(value: value ?? 0, measureType: MeasureType(rawValue: measureType) ?? .none)
    }

    public init(value: Float, measureType: MeasureType) {
        self.value = value
        self.measureType = measureType
    }
}
