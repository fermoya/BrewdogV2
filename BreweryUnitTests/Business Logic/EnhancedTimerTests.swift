//
//  BreweryUnitTests.swift
//  BreweryUnitTests
//

import XCTest
@testable import Brewery

class EnhancedTimerTest: XCTestCase {

    func test_CountDown() {
        let timer = EnhancedTimer(speed: 100)
        let expectation = XCTestExpectation(description: "Countdown")

        timer.schedule(duration: 2) { _ in
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }

    func test_PauseTimer() {
        let timer = EnhancedTimer(speed: 100)
        let expectation = XCTestExpectation(description: "Countdown")

        timer.schedule(duration: 2) { _ in
            expectation.fulfill()
        }

        sleep(1)
        timer.pause()
        timer.resume()

        wait(for: [expectation], timeout: 4)
    }

}

