//
//  BeersViewModelTests.swift
//  BreweryUnitTests
//

import XCTest
import APIKit
import Combine
@testable import Brewery

class BeersViewModelTests: XCTestCase {

    private var disposeBag = Set<AnyCancellable>()

    func test_GivenViewModel_WhenOnAppear_ThenFetchBeers() throws {
        let client = MockApiClient(data: beersData, error: nil, httpStatusCode: 200)
        let viewModel = BeersViewModel(apiClient: client)

        let expectation = self.expectation(description: "Expecting mock beers")

        var beers: [BeerCellViewModel]?
        viewModel.$beers
            .filter { !$0.isEmpty }
            .receive(on: RunLoop.current)
            .sink { result in
                beers = result
                expectation.fulfill()
            }
            .store(in: &disposeBag)

        viewModel.onAppear()
        waitForExpectations(timeout: 1)

        let unwrappedBeers = try XCTUnwrap(beers)
        XCTAssertFalse(unwrappedBeers.isEmpty)
        XCTAssertNil(viewModel.errorText)
    }

}

extension BeersViewModelTests {

    private var beersData: Data? {
        data(from: "beers")
    }

}
