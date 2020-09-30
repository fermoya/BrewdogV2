//
//  Ingredient.swift
//  Domain
//

import Foundation

public struct Ingredients: Decodable {
    public var malts: [Malt]
    public var hops: [Hop]
    public var yeast: String?

    private enum CodingKeys: String, CodingKey {
        case malts = "malt"
        case hops
        case yeast
    }
    
    public init(malts: [Malt], hops: [Hop], yeast: String?) {
        self.malts = malts
        self.hops = hops
        self.yeast = yeast
    }
}

public struct Malt: Decodable {
    public var name: String
    public var amount: Measure

    private enum CodingKeys: String, CodingKey {
        case name, amount
    }
    
    public init(name: String, amount: Measure) {
        self.name = name
        self.amount = amount
    }
}

public enum Timing: String {
    case start, middle, end, none
}

public struct Hop: Decodable {
    public var name: String
    public var amount: Measure
    public var timing: Timing
    public var attribute: String

    private enum CodingKeys: String, CodingKey {
        case name, amount, attribute
        case timing = "add"
    }

    public init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let name = try! container.decode(String.self, forKey: .name)
        let amount = try! container.decode(Measure.self, forKey: .amount)
        let attribute = try! container.decode(String.self, forKey: .attribute)
        let timing = try! container.decode(String.self, forKey: .timing)

        self.init(name: name, amount: amount, timing: Timing(rawValue: timing) ?? .start, attribute: attribute)
    }
    
    public init(name: String, amount: Measure, timing: Timing, attribute: String) {
        self.name = name
        self.amount = amount
        self.timing = timing
        self.attribute = attribute
    }
}
