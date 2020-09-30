//
//  BeerRecipeCellViewModel.swift
//  Brewery
//

import Foundation

class BeerRecipeCellViewModel: ObservableObject, Identifiable {

    private var recipeStep: RecipeStep
    private var recipeManager: RecipeManager

    @Published var state: RecipeStepState

    var id: Int { (recipeStep.name + recipeStep.metaInfo).hash }

    init(recipeStep: RecipeStep, recipeManager: RecipeManager) {
        self.recipeStep = recipeStep
        self.recipeManager = recipeManager
        self.state = recipeManager.checkState(of: recipeStep)
    }

    var title: String {
        "\(recipeStep.name)\n\(recipeStep.metaInfo)"
    }

    func onTapState() {
        let state = recipeManager.checkState(of: recipeStep)
        switch state {
        case .idle:
            recipeManager.start(recipeStep: recipeStep) { [weak self] (newState) in
                self?.state = newState
            }
        case .running:
            recipeManager.pause(recipeStep: recipeStep)
        case .paused:
            recipeManager.resume(recipeStep: recipeStep)
        default:
            return
        }
    }

}
