//
//  WorkoutBiometricsDataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/8/25.
//

import Foundation

struct WorkoutBiometricsDataProvider: BiometricsDataProvider, FakeDataProvider {
    private let startDate: Date
    private var lastReadingTime: Date
    
    let maxHeartRate: Double = 195
    var currentHeartRate: Double = 90
    var currentHeartRatePercentage: Double = 46.15
    var caloriesBurnt: Double = 0
    var splatPoints: Double = 0
    var name: String = "Nathan M"
    var timeSinceStart: TimeInterval = .zero
    
    // Workout phases in minutes: (duration, target HR percentage)
    private let workoutPattern: [(duration: Double, heartRatePercent: Double)] = [
        (5, 0.65),
        (3, 0.75),
        (2, 0.85),
        (3, 0.90),
        (2, 0.95),
        (3, 0.90),
        (2, 0.65)
    ]
    
    init(startDate: Date) {
        self.startDate = startDate
        self.lastReadingTime = startDate
    }
    
    mutating func executeDataMeasurement(forTime: Date) {
        let timeSinceLastReading = forTime.timeIntervalSince(lastReadingTime)
        timeSinceStart = forTime.timeIntervalSince(startDate)
        updateMetrics(timeSinceLastReading: timeSinceLastReading)
        lastReadingTime = forTime
    }
    
    mutating func executeHistoryDataMeasurement(forTime: Date) {
        // No-op as we're not tracking history
    }
    
    private mutating func updateMetrics(timeSinceLastReading: TimeInterval) {
        let minutes = timeSinceStart.minutes
        let totalDuration = workoutPattern.reduce(0) { $0 + $1.duration }
        let currentMinute = minutes.truncatingRemainder(dividingBy: totalDuration)
        
        // Find the current phase
        var accumulatedTime = 0.0
        var targetHR = currentHeartRate
        for phase in workoutPattern {
            accumulatedTime += phase.duration
            if currentMinute <= accumulatedTime {
                targetHR = maxHeartRate * phase.heartRatePercent
                break
            }
        }
        
        // Update heart rate gradually based on time since last reading
        let heartRateChangeRate = 0.4 // Adjust this value to control how quickly heart rate changes
        let heartRateChange = (targetHR - currentHeartRate) * heartRateChangeRate * (timeSinceLastReading / 60.0)
        currentHeartRate += heartRateChange
        
        currentHeartRatePercentage = (currentHeartRate / maxHeartRate) * 100
        
        let timeInMinutes = timeSinceLastReading / 60.0
        let calories = timeInMinutes * (
            0.6309 * currentHeartRate
            + 0.1988 * 70
            + 0.2017 * 25
            - 55.0969
        ) / 4.184
        
        caloriesBurnt += max(0, calories)
        
        if currentHeartRatePercentage > 84 {
            splatPoints += timeSinceLastReading / 60.0
        }
    }
}
