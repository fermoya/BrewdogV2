//
//  SolverTests.swift
//  ChallengeTests
//

import XCTest
@testable import Challenge

class SolverTests: XCTestCase {

    func test_GivenSolver_WhenSolveFile1_ThenExpectedOutput() {
        let solver = Solver()
        let challenge = Challenge.with(text: file1)
        let solution = solver.solve(challenge)
        XCTAssertEqual(solution.result, "C B C B C")
    }

    func test_GivenSolver_WhenSolveFile2_ThenExpectedOutput() {
        let solver = Solver()
        let challenge = Challenge.with(text: file2)
        let solution = solver.solve(challenge)
        XCTAssertEqual(solution.result, "C C C")
    }

    func test_GivenSolver_WhenSolveFile3_ThenExpectedOutput() {
        let solver = Solver()
        let challenge = Challenge.with(text: file3)
        let solution = solver.solve(challenge)
        XCTAssertEqual(solution.result, "C C")
    }

    func test_GivenSolver_WhenSolveFile4_ThenExpectedOutput() {
        let solver = Solver()
        let challenge = Challenge.with(text: file4)
        let solution = solver.solve(challenge)
        XCTAssertEqual(solution.result, "No solution exists")
    }

    func test_GivenSolver_WhenSolveFile5_ThenExpectedOutput() {
        let solver = Solver()
        let challenge = Challenge.with(text: file5)
        let solution = solver.solve(challenge)
        XCTAssertEqual(solution.result, "C C")
    }

    func test_GivenSolver_WhenSolveFile6_ThenExpectedOutput() {
        let solver = Solver()
        let challenge = Challenge.with(text: file6)
        let solution = solver.solve(challenge)
        XCTAssertEqual(solution.result, "C C")
    }

    func test_GivenSolver_WhenSolveFile7_ThenExpectedOutput() {
        let solver = Solver()
        let challenge = Challenge.with(text: file7)
        let solution = solver.solve(challenge)
        XCTAssertEqual(solution.result, "B B")
    }

}

extension SolverTests {

    private var file1: String {
        """
        5
        2 B
        5 C
        1 C
        5 C 1 C 4 B
        3 C
        5 C
        3 C 5 C 1 C
        3 C
        2 B
        5 C 1 C
        2 B
        5 C
        4 B
        5 C 4 B
        """
    }

    private var file2: String {
        """
        3
        1 C 2 B
        2 C 3 C
        1 B 3 C
        """
    }

    private var file3: String {
        """
        2
        1 C
        1 B 2 C
        """
    }

    private var file4: String {
        """
        2
        1 C 2 B
        1 B 2 C
        """
    }

    private var file5: String {
        """
        2
        1 C 2 C
        1 B 2 C
        """
    }

    private var file6: String {
        """
        2
        1 B 2 C
        1 B 2 C
        """
    }

    private var file7: String {
        """
        2
        1 C 2 B
        1 B
        """
    }

}
