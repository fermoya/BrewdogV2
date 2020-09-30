//
//  BeerRecipeSectionView.swift
//  Brewery
//

import SwiftUI

struct BeerRecipeSectionView: View {

    let viewModel: BeerRecipeSectionViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(viewModel.title)
                    .font(.subheadline)
                    .foregroundColor(Color(.sRGB, white: 0.2, opacity: 1))
                    .padding(4)
                Spacer()
            }
            .background(Color(.sRGB, white: 0.8, opacity: 1))
            .clipShape(RoundedRectangle(cornerRadius: 5))

            ForEach(viewModel.stepsViewModels) { viewModel in
                BeerRecipeCellView(viewModel: viewModel)
            }
        }
    }
}
