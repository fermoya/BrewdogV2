//
//  BeerDetailViewModel.swift
//  Brewery
//

import SwiftUI
import APIKit

protocol MeasureDescribable {
    var amount: Measure { get }
    var name: String { get }
    var measureDescription: String? { get }
}

extension MeasureType {
    var value: String {
        switch self {
        case .celsius:
            return "C"
        case .grams:
            return "g"
        case .kilograms:
            return "kg"
        case .litres:
            return "L"
        case .none:
            return ""
        }
    }
}

extension MeasureDescribable {
    var measureDescription: String? {
        if let value = amount.value {
            return "\(value) \(amount.measureType.value)\t\(name)"
        }
        return nil
    }
}

extension Malt: MeasureDescribable {}
extension Hop: MeasureDescribable {}

class BeerDetailViewModel {

    private let beer: Beer
    private let recipeManager: RecipeManager

    init(beer: Beer) {
        self.beer = beer
        self.recipeManager = RecipeManager(beer: beer)
    }

    var imageUrl: String? { beer.imageUrl }
    var name: String { beer.name }
    var description: String { beer.description }
    var alcoholPercentage: String { String(format: "%.2f%%", beer.abv) }

    var maltsSectionViewModel: BeerRecipeSectionViewModel {
        BeerRecipeSectionViewModel(title: "Malts",
                                   steps: beer.ingredients.malts,
                                   manager: recipeManager)
    }

    var hopsSectionViewModel: BeerRecipeSectionViewModel {
        BeerRecipeSectionViewModel(title: "Hops",
                                   steps: beer.ingredients.hops,
                                   manager: recipeManager)
    }

    var brewMethodsViewModel: BeerRecipeSectionViewModel {
        BeerRecipeSectionViewModel(title: "Brew methods",
                                   steps: beer.brewMethod.recipe,
                                   manager: recipeManager)
    }
}
