//
//  RecipeStep.swift
//  BusinessUseCases
//

import Foundation
import APIKit

public enum RecipeStepType {
    case malt, hop, method, twist
}

public protocol RecipeStep {
    var name: String { get }
    var metaInfo: String { get }
    var type: RecipeStepType { get }
    var duration: Int? { get }
    var timing: Timing { get }
}

extension Malt: RecipeStep {
    public var metaInfo: String { return "\(amount.value ?? 0) \(amount.measureType.rawValue)" }
    public var type: RecipeStepType { return .malt }
    public var duration: Int? { return nil }
    public var timing: Timing { return .none }
}

extension Hop: RecipeStep {
    public var type: RecipeStepType { return .hop }
    public var duration: Int? { return nil }
    public var metaInfo: String { return "\(amount.value ?? 0) \(amount.measureType.rawValue). Timing:  \(timing.rawValue)" }
}

extension Ingredients {
    public var recipe: [RecipeStep] {
        return malts.map { $0 as RecipeStep } + hops.map { $0 as RecipeStep }
    }
}

extension BrewMethod {
    public var recipe: [RecipeStep] {
        var steps = mashTemperatures.map { $0 as RecipeStep }
        steps.append(fermentation)
        
        if let twist = self.twist {
            steps.append(Twist(description: twist))
        }
        
        return steps
    }
}

extension MashTemperature: RecipeStep {
    public var metaInfo: String { return "\(temperature.value ?? 0) \(temperature.measureType.rawValue)" }
    
    public var name: String {
        return "Mash Temperature \(temperature.value ?? 0) \(temperature.measureType.rawValue)"
    }
    
    public var type: RecipeStepType {
        return .method
    }
    
    public var timing: Timing {
        return .none
    }
    
}

extension Fermentation: RecipeStep {
    public var metaInfo: String { return "\(temperature.value ?? 0) \(temperature.measureType.rawValue)" }

    public var name: String {
        return "Fermentation \(temperature.value ?? 0) \(temperature.measureType.rawValue)"
    }
    
    public var type: RecipeStepType {
        return .method
    }
    
    public var duration: Int? {
        return nil
    }
    
    public var timing: Timing {
        return .none
    }
    
}

public struct Twist: RecipeStep {
    public var description: String
    public var name: String { return "Twist" }
    public var metaInfo: String { return description }
    public var type: RecipeStepType { return .twist }
    
    public var duration: Int? { return nil }
    
    public var timing: Timing { return .none }
    
}
