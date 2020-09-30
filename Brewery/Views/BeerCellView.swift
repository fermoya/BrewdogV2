//
//  BeerCellView.swift
//  Brewery
//

import SwiftUI
import APIKit

struct BeerCellView: View {

    let viewModel: BeerCellViewModel
    @Environment(\.imageCache) private var imageCache

    var body: some View {
        HStack {
            if let urlString = viewModel.imageUrl,
               let url = URL(string: urlString) {
                AsyncImage(url: url,
                           placeholder: Text("Loading...").font(.caption),
                           cache: imageCache)
                    .frame(width: 60, height: 60)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.name)
                    .font(.headline)
                    .lineLimit(1)
                HStack {
                    Text(viewModel.twist.rawValue)
                        .foregroundColor(viewModel.twist == .classic ? .gray : .red)
                    Spacer()
                    Text(viewModel.alcoholPercentage)
                }
                .font(.caption)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Brewery Challenge")
    }
}
