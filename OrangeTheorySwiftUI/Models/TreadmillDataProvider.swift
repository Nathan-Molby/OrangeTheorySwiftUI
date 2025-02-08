//
//  DataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import Foundation

/// The provider for the treadmill data
/// All histories should base their duration from when the treadmill "turned on"
protocol TreadmillDataProvider {
    /// The user's current distance ran on the treadmill
    var currentDistance: Measurement<UnitLength> { get }
    
    /// The user's current time on the treadmill
    var timeSinceStart: Measurement<UnitDuration> { get }
    
    /// The user's current incline on the treadmill
    var currentIncline: Measurement<UnitAngle> { get }
    
    /// The user's current speed on the treadmill
    var currentSpeed: Measurement<UnitSpeed> { get }

    /// A list of the user's speeds at points in time since they began running.
    /// The key must be >= 0 and <= currentTime
    var speedHistory: [Measurement<UnitDuration>: Measurement<UnitSpeed>] { get }
    
    /// A list of the user's incline at points in time since they began running.
    /// The key must be >= 0 and <= currentTime
    var inclineHistory: [Measurement<UnitDuration>: Measurement<UnitAngle>] { get }
    
}
