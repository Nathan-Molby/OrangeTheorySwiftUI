//
//  WorkoutTreadmillDataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/15/25.
//

import Foundation

struct WorkoutTreadmillDataProvider: FakeTreadmillDataProvider {
    let startDate: Date
    var currentIncline: Measurement<UnitAngle>
    var currentSpeed: Measurement<UnitSpeed>
    var currentDistance: Measurement<UnitLength> = .init(value: 0, unit: .meters)
    var timeSinceStart: Measurement<UnitDuration> = .init(value: 0, unit: .seconds)
    var speedHistory: [Measurement<UnitDuration> : Measurement<UnitSpeed>] = [:]
    var inclineHistory: [Measurement<UnitDuration> : Measurement<UnitAngle>] = [:]
    
    // Workout phases in minutes: (duration, speed in mph, incline in %)
    private let workoutPattern: [(Double, Double, Double)] = [
        (5, 3.1, 0),    // Warm-up walk
        (3, 5.0, 1),    // Light jog with slight incline
        (2, 6.2, 2),    // Run
        (3, 4.3, 3),    // Recovery with higher incline
        (2, 6.8, 1),    // Fast run
        (3, 3.7, 2),    // Cool down jog
        (2, 2.5, 0)     // Final walking cool down
    ]
    
    private lazy var patternDuration: Double = {
        return workoutPattern.reduce(0) { $0 + $1.0 }
    }()
    
    init(startDate: Date) {
        self.startDate = startDate
        self.currentIncline = .init(value: 0, unit: .incline)
        self.currentSpeed = .init(value: 3.1, unit: .milesPerHour)
    }
    
    mutating func executeDataMeasurement(forTime: Date) {
        let previousTime = timeSinceStart
        timeSinceStart = Measurement<UnitDuration>(value: forTime.timeIntervalSince(startDate), unit: .seconds)
        
        updateWorkoutPhase()
        
        let timeElapsed = timeSinceStart - previousTime
        currentDistance += currentSpeed * timeElapsed
    }
    
    mutating func executeHistoryDataMeasurement(forTime: Date) {
        timeSinceStart = Measurement<UnitDuration>(value: forTime.timeIntervalSince(startDate), unit: .seconds)
        speedHistory[timeSinceStart] = currentSpeed
        inclineHistory[timeSinceStart] = currentIncline
    }
    
    private mutating func updateWorkoutPhase() {
        let elapsedMinutes = timeSinceStart.converted(to: .minutes).value
        
        // Calculate which iteration of the pattern we're on
        let normalizedElapsedMinutes = elapsedMinutes.truncatingRemainder(dividingBy: patternDuration)
        
        var accumulatedTime = 0.0
        
        for (duration, speed, incline) in workoutPattern {
            accumulatedTime += duration
            if normalizedElapsedMinutes <= accumulatedTime {
                currentSpeed = .init(value: speed, unit: .milesPerHour)
                currentIncline = .init(value: incline, unit: .incline)
                break
            }
        }
    }
}
