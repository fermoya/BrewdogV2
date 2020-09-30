//
//  BeersView.swift
//  Brewery
//

import SwiftUI

struct BeersView: View {

    @ObservedObject var viewModel: BeersViewModel

    var body: some View {
        NavigationView {
            Group {
                if let text = viewModel.errorText {
                    Text(text)
                } else if viewModel.beers.isEmpty {
                    ProgressView()
                } else {
                    beerList
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }

    private var beerList: some View {
        List {
            ForEach((0..<viewModel.beers.count), id: \.self) { index in
                NavigationLink(destination: BeerDetailView(viewModel: viewModel.detailsViewModel(at: index))) {
                    BeerCellView(viewModel: viewModel.beers[index])
                        .onAppear {
                            viewModel.onCellAppear(at: index)
                        }
                }
            }
        }
    }
}

struct BeersView_Previews: PreviewProvider {
    static var previews: some View {
        BeersView(viewModel: .init())
    }
}
