//
//  Method.swift
//  Domain
//

import Foundation

public struct BrewMethod: Decodable {
    public var mashTemperatures: [MashTemperature]
    public var fermentation: Fermentation
    public var twist: String?

    private enum CodingKeys: String, CodingKey {
        case fermentation, twist
        case mashTemperatures = "mash_temp"
    }

    public init(mashTemperatures: [MashTemperature], fermentation: Fermentation, twist: String? = nil) {
        self.mashTemperatures = mashTemperatures
        self.fermentation = fermentation
        self.twist = twist
    }
    
}

public struct MashTemperature: Decodable {
    public var temperature: Measure
    public var duration: Int?

    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case duration
    }

    public init(temperature: Measure, duration: Int? = nil) {
        self.temperature = temperature
        self.duration = duration
    }
}

public struct Fermentation: Decodable {
    public var temperature: Measure

    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }

    public init(temperature: Measure) {
        self.temperature = temperature
    }
}
