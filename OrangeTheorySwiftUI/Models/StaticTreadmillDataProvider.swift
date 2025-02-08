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
    
    var timeSinceStart: Measurement<UnitDuration> = .init(value: 0, unit: .seconds)
    
    var speedHistory: [Measurement<UnitDuration> : Measurement<UnitSpeed>] = [:]
    
    var inclineHistory: [Measurement<UnitDuration> : Measurement<UnitAngle>] = [:]
    
    mutating func executeDataMeasurement(forTime: Date) {
        timeSinceStart = Measurement<UnitDuration>(value: forTime - startDate, unit: .seconds)
        
        currentDistance += currentSpeed * timeSinceStart
    }
    
    mutating func executeHistoryDataMeasurement(forTime: Date) {
        timeSinceStart = Measurement<UnitDuration>(value: forTime - startDate, unit: .seconds)
        speedHistory[timeSinceStart] = currentSpeed
        inclineHistory[timeSinceStart] = currentIncline
    }
}
