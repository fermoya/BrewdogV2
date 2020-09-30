//
//  BrewedItem.swift
//  Domain
//

import Foundation

public struct Beer: Decodable {
    public var id: Int
    public var tagLine: String
    public var name: String
    public var abv: Float
    public var description: String
    public var imageUrl: String?
    public var brewMethod: BrewMethod
    public var ingredients: Ingredients

    private enum CodingKeys: String, CodingKey {
        case id, name, abv, description, ingredients
        case tagLine = "tagline"
        case imageUrl = "image_url"
        case brewMethod = "method"
    }
    
    public init(id: Int, tagLine: String, name: String, abv: Float, description: String, imageUrl: String, brewMethod: BrewMethod, ingredients: Ingredients) {
        self.id = id
        self.tagLine = tagLine
        self.name = name
        self.abv = abv
        self.description = description
        self.imageUrl = imageUrl
        self.brewMethod = brewMethod
        self.ingredients = ingredients
    }
    
}
