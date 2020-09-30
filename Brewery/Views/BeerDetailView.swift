//
//  BeerDetailView.swift
//  Brewery
//

import SwiftUI

struct BeerDetailView: View {

    let viewModel: BeerDetailViewModel
    @Environment(\.imageCache) private var imageCache

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    if let urlString = viewModel.imageUrl,
                       let url = URL(string: urlString) {
                        AsyncImage(url: url,
                                   placeholder: Text("Loading...").font(.caption),
                                   cache: imageCache)
                            .frame(width: proxy.size.width,
                                   height: proxy.size.width * 9 / 16)
                    }
                    content
                }
            }
        }
        .padding()
        .navigationBarTitle("Details", displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
    }

    private var content: some View {
        LazyVStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading, spacing: 3) {
                Text(viewModel.name)
                    .font(.title)
                Text(viewModel.alcoholPercentage)
                    .foregroundColor(.gray)
                    .font(.title3)
            }
            Text(viewModel.description)
            BeerRecipeSectionView(viewModel: viewModel.hopsSectionViewModel)
            BeerRecipeSectionView(viewModel: viewModel.maltsSectionViewModel)
            BeerRecipeSectionView(viewModel: viewModel.brewMethodsViewModel)
        }
    }
}
