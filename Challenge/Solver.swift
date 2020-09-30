//
//  Solver.swift
//  Challenge
//

import Foundation

public class Solver {

    public init() { }

    public func solve(_ challenge: Challenge?) -> Solution {
        guard let challenge = challenge else { return Solution.none }
        return solve(challenge, possible: Solution.default(challenge.count), it: 1)
    }

    private func solve(_ challenge: Challenge, possible solution: Solution, kind: Beer.Kind = .classic, it: Int) -> Solution {
        guard it <= challenge.count else { return solution }
        let users = challenge.users.filter { $0.preferredBeers.count == it && !$0.isSatisfied(by: solution) } // priority to less beers
        guard !users.isEmpty else {
            return solve(challenge, possible: solution, it: it + 1)
        }

        var allSatisfied = false
        var unsolvable = false
        while(!(unsolvable || allSatisfied)) {
            var hasSolutionChanged = false
            (1...challenge.count)
                .filter { solution.canSolve($0) }
                .forEach { beerId in
                    let users = users.filter { $0.likes(beerId) && !$0.isSatisfied(by: solution) }
                    let isUnanimous = users.allSatisfy { $0.preferredKind(for: beerId) == kind }
                    if isUnanimous, !users.isEmpty {
                        solution.solve(beerId, with: kind)
                        hasSolutionChanged = true
                    }
                }

            allSatisfied = users.allSatisfy { $0.isSatisfied(by: solution) }
            if !allSatisfied && !hasSolutionChanged {
                unsolvable = true
            }
        }

        guard !unsolvable else {
            return kind == .barrelAged ? .none : solve(challenge, possible: solution, kind: .barrelAged, it: it)
        }
        return solve(challenge, possible: solution, it: it + 1)
    }
}
