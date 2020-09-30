//
//  Beer.swift
//  Challenge
//

import Foundation

struct Beer {
    enum Kind: String, CaseIterable {
        case classic = "C"
        case barrelAged = "B"
    }

    let id: Int
    let kind: Kind
}
