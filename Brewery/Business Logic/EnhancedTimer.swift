//
//  EnhancedTimer.swift
//  Brewery
//

import Foundation

class EnhancedTimer {

    weak var timer: Timer?

    private(set) var duration = 0
    private(set) var elapsedTime = 0

    private let speed: Int

    var remainigTime: Int {
        return duration - elapsedTime
    }

    init(speed: Int = 1) {
        self.speed = speed
    }

    private var handler: ((RecipeStepState) -> Void)?

    func schedule(duration: Int, handler: ((RecipeStepState) -> Void)? = nil) {
        self.duration = duration
        self.handler = handler
        timer = Timer.scheduledTimer(withTimeInterval: 1 / Double(speed), repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.elapsedTime += 1
            if self.elapsedTime >= duration {
                self.timer?.invalidate()
                handler?(.done)
            } else {
                handler?(.running(self.remainigTime))
            }
        }
    }

    func pause() {
        timer?.invalidate()
    }

    func resume() {
        schedule(duration: duration, handler: handler)
    }

}
