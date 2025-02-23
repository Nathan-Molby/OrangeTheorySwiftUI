//
//  MockTreadmillDataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/23/25.
//

@testable import OrangeTheorySwiftUI
import Foundation

class MockTreadmillDataProvider: TreadmillDataProvider {
    var currentDistance: Measurement<UnitLength>
    var timeSinceStart: Measurement<UnitDuration>
    var currentIncline: Measurement<UnitAngle>
    var currentSpeed: Measurement<UnitSpeed>
    var speedHistory: [Measurement<UnitDuration>: Measurement<UnitSpeed>]
    var inclineHistory: [Measurement<UnitDuration>: Measurement<UnitAngle>]
    
    init(
        currentDistance: Measurement<UnitLength> = Measurement(value: 0, unit: .meters),
        timeSinceStart: Measurement<UnitDuration> = Measurement(value: 0, unit: .seconds),
        currentIncline: Measurement<UnitAngle> = Measurement(value: 0, unit: .degrees),
        currentSpeed: Measurement<UnitSpeed> = Measurement(value: 0, unit: .metersPerSecond),
        speedHistory: [Measurement<UnitDuration>: Measurement<UnitSpeed>] = [:],
        inclineHistory: [Measurement<UnitDuration>: Measurement<UnitAngle>] = [:]
    ) {
        self.currentDistance = currentDistance
        self.timeSinceStart = timeSinceStart
        self.currentIncline = currentIncline
        self.currentSpeed = currentSpeed
        self.speedHistory = speedHistory
        self.inclineHistory = inclineHistory
    }
}
