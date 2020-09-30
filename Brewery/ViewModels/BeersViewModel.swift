//
//  BeersViewModel.swift
//  Brewery
//

import Foundation
import Combine
import APIKit
import Challenge

class BeersViewModel: ObservableObject {

    @Published var beers: [BeerCellViewModel] = []
    @Published var errorText: String?

    private let apiClient: Webservice
    private var disposeBag = Set<AnyCancellable>()

    private var page = 0

    init(apiClient: Webservice = ApiClient()) {
        self.apiClient = apiClient
    }

    func onAppear() {
        fetchItems()
        solveChallenge()
    }

    func onCellAppear(at index: Int) {
        if index > Int(0.9 * Double(beers.count)) {
            fetchItems()
        }
    }

    private func solveChallenge() {
        apiClient
            .send(ChallengeGetRequest())
            .plainText()
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("[CHALLENGE] Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { file in
                let challenge = Challenge.with(text: file)
                let solution = Solver().solve(challenge)
                print(solution.result)
            }
            .store(in: &disposeBag)
    }

    private func fetchItems() {
        apiClient
            .send(BeersGetRequest())
            .jsonPublisher()
            .map { (newBeers: [Beer]) -> [BeerCellViewModel] in
                let newBeers = newBeers.map { BeerCellViewModel(beer: $0) }
                return self.beers + newBeers
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    self.page += 1
                case .failure(let error):
                    self.errorText = "\(error): \(error.localizedDescription)"
                }
            }, receiveValue: { (beers) in
                self.beers = beers
            })
            .store(in: &disposeBag)
    }

    func detailsViewModel(at index: Int) -> BeerDetailViewModel {
        beers[index].detailViewModel
    }

}
