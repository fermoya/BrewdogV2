//
//  Challenge.swift
//  Brewery
//

import Foundation

public struct Challenge {

    let count: Int
    let users: [User]

    public static func with(text: String) -> Challenge? {
        var lines = text.split(separator: "\n").map { String($0) }
        guard let count = extractItemsCount(from: &lines) else { return nil }
        let users = lines.compactMap(User.init)
        return Challenge(count: count, users: users)
    }

    private static func extractItemsCount(from lines: inout [String]) -> Int? {
        guard let firstLine = lines.first?.trimmingCharacters(in: .whitespacesAndNewlines),
              let count = Int(firstLine) else { return nil }
        lines = Array(lines.dropFirst())
        return count
    }

}
