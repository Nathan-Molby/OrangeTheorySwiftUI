//
//  StaticTreadmillDataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import Foundation

/// A basic treadmill data provider that stays at the input speed and incline.
struct StaticTreadmillDataProvider: TreadmillDataProvider {

    var currentIncline: Measurement<UnitAngle>
    var currentSpeed: Measurement<UnitSpeed>
    let startDate: Date
    
    init(incline: Measurement<UnitAngle>, speed: Measurement<UnitSpeed>) {
        currentIncline = incline
        currentSpeed = speed
        startDate = .now
    }
    
    var currentDistance: Measurement<UnitLength> = .init(value: 0, unit: .meters)
    
    var currentTime: Measurement<UnitDuration> = .init(value: 0, unit: .seconds)
    
    var speedHistory: [Measurement<UnitDuration> : Measurement<UnitSpeed>] = [:]
    
    var inclineHistory: [Measurement<UnitDuration> : Measurement<UnitAngle>] = [:]
    
    /// Updates the currentDistance and currentTime
    mutating func executeCurrentDataMeasurement() {
        let oldTime = currentTime
        currentTime = .init(value: Date.now - startDate, unit: .seconds)
        
        currentDistance += currentSpeed * (currentTime - oldTime)
    }
    
    /// Updates speedHistory and inclineHistory
    mutating func executeHistoryDataMeasurement() {
        speedHistory[currentTime] = currentSpeed
        inclineHistory[currentTime] = currentIncline
    }
}
