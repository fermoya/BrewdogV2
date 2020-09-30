//
//  User.swift
//  Challenge
//

import Foundation

struct User {
    var preferredBeers: [Beer]

    init?(line: String) {
        let parts = line.split(separator: " ").map { String($0) }
        guard parts.count.isEven else { return nil }

        let beerIds = parts.filteringEvenPositions().compactMap { Int($0) }
        let beerKinds = parts.filteringOddPositions().compactMap { Beer.Kind(rawValue: $0) }
        guard beerIds.count == beerKinds.count else { return nil }
        guard !beerIds.isEmpty else { return nil }

        let beers = (0..<beerIds.count)
            .compactMap { index -> Beer in
                let id = beerIds[index]
                let kind = beerKinds[index]
                return Beer(id: id, kind: kind)
            }
        self.preferredBeers = beers
    }
}

extension User {

    func isSatisfied(by solution: Solution) -> Bool {
        return preferredBeers
            .map { beer -> Bool in
                let solution = solution.result(for: beer.id)
                return solution?.rawValue == beer.kind.rawValue
            }
            .reduce(false) { $0 || $1 }
    }

    func preferredKind(for beerId: Int) -> Beer.Kind? {
        preferredBeers.first { $0.id == beerId }?.kind
    }

    func likes(_ beerId: Int) -> Bool {
        preferredBeers.contains { $0.id == beerId }
    }

}
