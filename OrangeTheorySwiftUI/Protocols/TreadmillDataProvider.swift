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

extension TreadmillDataProvider {
    /// The user's average speed on the treadmill, weighted by time intervals
    var averageSpeed: Measurement<UnitSpeed> {
        guard !speedHistory.isEmpty else {
            return Measurement(value: 0, unit: UnitSpeed.metersPerSecond)
        }
        
        // Handle single entry case
        guard speedHistory.count > 1 else {
            return speedHistory.first!.value
        }
        
        // Sort entries by time
        let sortedEntries = speedHistory.sorted { $0.key.value < $1.key.value }
        var weightedSum = 0.0
        var totalDuration = 0.0
        
        // Calculate weighted average using time intervals
        for i in 0..<(sortedEntries.count - 1) {
            let currentTime = sortedEntries[i].key.value
            let nextTime = sortedEntries[i + 1].key.value
            let duration = nextTime - currentTime
            let speed = sortedEntries[i].value.value
            
            weightedSum += speed * duration
            totalDuration += duration
        }
        
        // Include the last entry with the remaining time up to current time
        if let lastEntry = sortedEntries.last {
            let remainingDuration = timeSinceStart.value - lastEntry.key.value
            if remainingDuration > 0 {
                weightedSum += lastEntry.value.value * remainingDuration
                totalDuration += remainingDuration
            }
        }
        
        let averageValue = totalDuration > 0 ? weightedSum / totalDuration : 0
        return Measurement(value: averageValue, unit: UnitSpeed.metersPerSecond)
    }
    
    /// The user's average incline on the treadmill, weighted by time intervals
    var averageIncline: Measurement<UnitAngle> {
        guard !inclineHistory.isEmpty else {
            return Measurement(value: 0, unit: UnitAngle.degrees)
        }
        
        // Handle single entry case
        guard inclineHistory.count > 1 else {
            return inclineHistory.first!.value
        }
        
        // Sort entries by time
        let sortedEntries = inclineHistory.sorted { $0.key.value < $1.key.value }
        var weightedSum = 0.0
        var totalDuration = 0.0
        
        // Calculate weighted average using time intervals
        for i in 0..<(sortedEntries.count - 1) {
            let currentTime = sortedEntries[i].key.value
            let nextTime = sortedEntries[i + 1].key.value
            let duration = nextTime - currentTime
            let incline = sortedEntries[i].value.value
            
            weightedSum += incline * duration
            totalDuration += duration
        }
        
        // Include the last entry with the remaining time up to current time
        if let lastEntry = sortedEntries.last {
            let remainingDuration = timeSinceStart.value - lastEntry.key.value
            if remainingDuration > 0 {
                weightedSum += lastEntry.value.value * remainingDuration
                totalDuration += remainingDuration
            }
        }
        
        let averageValue = totalDuration > 0 ? weightedSum / totalDuration : 0
        return Measurement(value: averageValue, unit: UnitAngle.degrees)
    }
}
