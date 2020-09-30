//
//  BeerCellViewModel.swift
//  Brewery
//

import APIKit

extension Beer {
    enum Kind: String {
        case classic = "CLASSIC"
        case barrelAged = "BARREL AGED"
    }
}

class BeerCellViewModel: Identifiable {

    private let beer: Beer

    init(beer: Beer) {
        self.beer = beer
    }

    var id: Int { beer.id }
    var imageUrl: String? { beer.imageUrl }
    var name: String { beer.name }
    var alcoholPercentage: String { String(format: "%.2f%%", beer.abv) }
    var twist: Beer.Kind {
        beer.brewMethod.twist == nil ? .classic : .barrelAged
    }

    var detailViewModel: BeerDetailViewModel {
        BeerDetailViewModel(beer: beer)
    }
}
