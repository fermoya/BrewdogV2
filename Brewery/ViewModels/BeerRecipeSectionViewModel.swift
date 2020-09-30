//
//  BeerRecipeSectionViewModel.swift
//  Brewery
//

import Foundation

class BeerRecipeSectionViewModel {

    let title: String
    private let steps: [RecipeStep]
    private var manager: RecipeManager

    init(title: String, steps: [RecipeStep], manager: RecipeManager) {
        self.title = title
        self.steps = steps
        self.manager = manager
    }

    var stepsViewModels: [BeerRecipeCellViewModel] {
        steps.map { BeerRecipeCellViewModel(recipeStep: $0, recipeManager: manager) }
    }

}
