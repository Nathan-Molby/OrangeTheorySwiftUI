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
    
    var timeSinceStart: TimeInterval = .minute(15)
    
    var speedHistory: [(time: TimeInterval, speed: Measurement<UnitSpeed>)] = [
        (.minute(0), .init(value: 3.0, unit: .milesPerHour)),
        (.minute(3), .init(value: 5.0, unit: .milesPerHour)),
        (.minute(6), .init(value: 6.0, unit: .milesPerHour)),
        (.minute(9), .init(value: 7.0, unit: .milesPerHour)),
        (.minute(12), .init(value: 6.5, unit: .milesPerHour)),
        (.minute(15), .init(value: 6.5, unit: .milesPerHour)),
        (.minute(16), .init(value: 1.0, unit: .milesPerHour)),
        (.minute(20), .init(value: 5.0, unit: .milesPerHour))
    ]
    
    var inclineHistory: [(time: TimeInterval, angle: Measurement<UnitAngle>)] = [
        (.minute(0), .init(value: 1, unit: .incline)),
        (.minute(3), .init(value: 2, unit: .incline)),
        (.minute(6), .init(value: 3, unit: .incline)),
        (.minute(9), .init(value: 4, unit: .incline)),
        (.minute(12), .init(value: 3, unit: .incline)),
        (.minute(15), .init(value: 2, unit: .incline))
    ]
}
