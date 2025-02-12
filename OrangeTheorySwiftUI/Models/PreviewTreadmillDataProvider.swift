//
//  PreviewTreadmillDataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/9/25.
//

import Foundation

/// A treadmill data provider that comes prepopulated for use in previews
struct PreviewTreadmillDataProvider: TreadmillDataProvider {

    var currentIncline: Measurement<UnitAngle> = .init(value: 4, unit: .incline)
    var currentSpeed: Measurement<UnitSpeed> = .init(value: 7, unit: .milesPerHour)
    let startDate: Date = .now
    
    var currentDistance: Measurement<UnitLength> = .init(value: 1.7, unit: .miles)
    
    var timeSinceStart: Measurement<UnitDuration> = .init(value: 15, unit: .minutes)
    
    var speedHistory: [Measurement<UnitDuration> : Measurement<UnitSpeed>] = [
        .init(value: 0, unit: .minutes): .init(value: 3.0, unit: .milesPerHour),
        .init(value: 3, unit: .minutes): .init(value: 5.0, unit: .milesPerHour),
        .init(value: 6, unit: .minutes): .init(value: 6.0, unit: .milesPerHour),
        .init(value: 9, unit: .minutes): .init(value: 7.0, unit: .milesPerHour),
        .init(value: 12, unit: .minutes): .init(value: 6.5, unit: .milesPerHour),
        .init(value: 15, unit: .minutes): .init(value: 6.5, unit: .milesPerHour),
        .init(value: 16, unit: .minutes): .init(value: 1, unit: .milesPerHour),
        .init(value: 20, unit: .minutes): .init(value: 5, unit: .milesPerHour)
    ]
    
    var inclineHistory: [Measurement<UnitDuration> : Measurement<UnitAngle>] = [
        .init(value: 0, unit: .minutes): .init(value: 1, unit: .incline),
        .init(value: 3, unit: .minutes): .init(value: 2, unit: .incline),
        .init(value: 6, unit: .minutes): .init(value: 3, unit: .incline),
        .init(value: 9, unit: .minutes): .init(value: 4, unit: .incline),
        .init(value: 12, unit: .minutes): .init(value: 3, unit: .incline),
        .init(value: 15, unit: .minutes): .init(value: 2, unit: .incline)
    ]
}
