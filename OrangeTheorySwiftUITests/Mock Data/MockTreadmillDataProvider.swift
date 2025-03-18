//
//  MockTreadmillDataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/23/25.
//

@testable import OrangeTheorySwiftUI
import Foundation

class MockTreadmillDataProvider: TreadmillDataProvider {
    var timeSinceStart: TimeInterval
    
    var speedHistory: [(time: TimeInterval, speed: Measurement<UnitSpeed>)]
    var inclineHistory: [(time: TimeInterval, angle: Measurement<UnitAngle>)]
    
    var currentDistance: Measurement<UnitLength>
    var currentIncline: Measurement<UnitAngle>
    var currentSpeed: Measurement<UnitSpeed>
    
    init(
        currentDistance: Measurement<UnitLength> = Measurement(value: 0, unit: .meters),
        timeSinceStart: TimeInterval = 0,
        currentIncline: Measurement<UnitAngle> = Measurement(value: 0, unit: .degrees),
        currentSpeed: Measurement<UnitSpeed> = Measurement(value: 0, unit: .metersPerSecond),
        speedHistory: [(time: TimeInterval, speed: Measurement<UnitSpeed>)] = [],
        inclineHistory: [(time: TimeInterval, angle: Measurement<UnitAngle>)] = []
    ) {
        self.currentDistance = currentDistance
        self.timeSinceStart = timeSinceStart
        self.currentIncline = currentIncline
        self.currentSpeed = currentSpeed
        self.speedHistory = speedHistory
        self.inclineHistory = inclineHistory
    }
}
