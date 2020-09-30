//
//  BreweryApp.swift
//  Brewery
//

import SwiftUI

@main
struct BreweryApp: App {

    @StateObject private var beersViewModel = BeersViewModel()

    var body: some Scene {
        WindowGroup {
            BeersView(viewModel: beersViewModel)
        }
    }
}
