//
//  Solution.swift
//  Challenge
//

import Foundation

public class Solution {

    private enum Constants {
        static let separator = " "
    }

    enum IndividualSolution: String {
        case classic = "C", barrelAged = "B", any = "X"
    }

    static let none = Solution()

    static func `default`(_ count: Int) -> Solution {
        Solution(solutions: Array(repeating: .any, count: count))
    }

    private var solutions: [IndividualSolution]

    private init(solutions: [IndividualSolution] = []) {
        self.solutions = solutions
    }

    var debugResult: String {
        guard !solutions.isEmpty else { return "No solution exists" }
        return solutions
            .map { $0.rawValue }
            .joined(separator: Constants.separator)
    }

    public var result: String {
        return debugResult.replacingOccurrences(of: IndividualSolution.any.rawValue,
                                                with: IndividualSolution.classic.rawValue)
    }

    func result(for id: Int) -> IndividualSolution? {
        guard solutions.indices.contains(id - 1) else { return nil }
        return solutions[id-1]
    }

    func canSolve(_ id: Int) -> Bool {
        guard solutions.indices.contains(id - 1) else { return false }
        return solutions[id-1] == .any
    }

    func solve(_ id: Int, with kind: Beer.Kind) {
        guard solutions.indices.contains(id - 1) else { return }
        switch kind {
        case .barrelAged:
            solutions[id-1] = .barrelAged
        case .classic:
            solutions[id-1] = .classic
        }
    }

}
