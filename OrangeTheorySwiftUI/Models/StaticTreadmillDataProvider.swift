//
//  StaticTreadmillDataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import Foundation

/// A basic treadmill data provider that stays at the input speed and incline.
struct StaticTreadmillDataProvider: FakeTreadmillDataProvider {
    var currentIncline: Measurement<UnitAngle>
    var currentSpeed: Measurement<UnitSpeed>
    let startDate: Date
    
    init(startDate: Date, incline: Measurement<UnitAngle>, speed: Measurement<UnitSpeed>) {
        currentIncline = incline
        currentSpeed = speed
        self.startDate = startDate
    }
    
    var currentDistance: Measurement<UnitLength> = .init(value: 0, unit: .meters)
    
    var timeSinceStart: TimeInterval = .second(0)
    
    var speedHistory: [(time: TimeInterval, speed: Measurement<UnitSpeed>)] = []
    
    var inclineHistory: [(time: TimeInterval, angle: Measurement<UnitAngle>)] = []
    
    mutating func executeDataMeasurement(forTime: Date) {
        timeSinceStart = forTime.timeIntervalSince(startDate)
        
        let elapsedTime = Measurement(value: timeSinceStart, unit: UnitDuration.seconds)
        currentDistance += currentSpeed * elapsedTime
    }
    
    mutating func executeHistoryDataMeasurement(forTime: Date) {
        timeSinceStart = forTime.timeIntervalSince(startDate)
        speedHistory.append((time: timeSinceStart, speed: currentSpeed))
        inclineHistory.append((time: timeSinceStart, angle: currentIncline))
    }
}
