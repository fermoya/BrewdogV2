//
//  BeerRecipeCellView.swift
//  Brewery
//

import SwiftUI

struct BeerRecipeCellView: View {

    @ObservedObject var viewModel: BeerRecipeCellViewModel

    var body: some View {
        HStack {
            Text(viewModel.title)
                .font(.caption)
                .lineLimit(2)
                .padding(.horizontal, 4)
            Spacer()
            Button {
                viewModel.onTapState()
            } label: {
                Text(viewModel.state.value)
                    .foregroundColor(color(for: viewModel.state))
                    .frame(width: 80, height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(color(for: viewModel.state), lineWidth: 2)
                    )
            }
        }
        .padding(.horizontal)
    }

    private func color(for state: RecipeStepState) -> Color {
        switch state {
        case .done:
            return .green
        case .idle:
            return .gray
        case .paused:
            return .yellow
        case .running:
            return .blue
        }
    }

}
