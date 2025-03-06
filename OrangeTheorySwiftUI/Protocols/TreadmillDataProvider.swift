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
    var timeSinceStart: TimeInterval { get }
    
    /// The user's current incline on the treadmill
    var currentIncline: Measurement<UnitAngle> { get }
    
    /// The user's current speed on the treadmill
    var currentSpeed: Measurement<UnitSpeed> { get }

    /// A list of the user's speeds at points in time since they began running.
    /// The key must be >= 0 and <= currentTime
    var speedHistory: [(time: TimeInterval, speed: Measurement<UnitSpeed>)] { get }
    
    /// A list of the user's incline at points in time since they began running.
    /// The key must be >= 0 and <= currentTime
    var inclineHistory: [(time: TimeInterval, angle: Measurement<UnitAngle>)] { get }
}

extension TreadmillDataProvider {
    /// The user's average speed on the treadmill, weighted by time intervals
    var averageSpeed: Measurement<UnitSpeed> {
        guard !speedHistory.isEmpty else {
            return Measurement(value: 0, unit: UnitSpeed.metersPerSecond)
        }
        
        guard speedHistory.count > 1 else {
            return speedHistory.first!.speed
        }
        
        var weightedSum = 0.0
        var totalDuration = 0.0
        
        // Calculate weighted average using time intervals
        for i in 0..<(speedHistory.count - 1) {
            let currentTime = speedHistory[i].time
            let nextTime = speedHistory[i + 1].time
            let duration = nextTime - currentTime
            let speed = speedHistory[i].speed.converted(to: .metersPerSecond).value
            
            weightedSum += speed * duration
            totalDuration += duration
        }
        
        // Include the last entry with the remaining time up to current time
        if let lastEntry = speedHistory.last {
            let remainingDuration = timeSinceStart - lastEntry.time
            if remainingDuration > 0 {
                weightedSum += lastEntry.speed.value * remainingDuration
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
        
        guard inclineHistory.count > 1 else {
            return inclineHistory.first!.angle
        }
        
        // Sort entries by time
        var weightedSum = 0.0
        var totalDuration = 0.0
        
        // Calculate weighted average using time intervals
        for i in 0..<(inclineHistory.count - 1) {
            let currentTime = inclineHistory[i].time
            let nextTime = inclineHistory[i + 1].time
            let duration = nextTime - currentTime
            let incline = inclineHistory[i].angle.converted(to: .degrees).value
            
            weightedSum += incline * duration
            totalDuration += duration
        }
        
        // Include the last entry with the remaining time up to current time
        if let lastEntry = inclineHistory.last {
            let remainingDuration = timeSinceStart - lastEntry.time
            if remainingDuration > 0 {
                weightedSum += lastEntry.angle.converted(to: .degrees).value * remainingDuration
                totalDuration += remainingDuration
            }
        }
        
        let averageValue = totalDuration > 0 ? weightedSum / totalDuration : 0
        return Measurement(value: averageValue, unit: UnitAngle.degrees)
    }
}
