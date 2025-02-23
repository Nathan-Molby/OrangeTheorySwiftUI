//
//  Configuration.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/9/25.
//

import Foundation

struct Configuration {
    var lengthUnit: UnitLength = .miles
    var speedUnit: UnitSpeed = .milesPerHour
    var inclineUnit: UnitAngle = .incline
    var trackDistance: Measurement<UnitLength> = .init(value: 0.25, unit: .miles)
    var chartWidth = Measurement<UnitDuration>(value: 5, unit: .minutes)
    
    func formatLength(_ input: Measurement<UnitLength>) -> MetricWithUnit {
        let convertedInput = input.converted(to: lengthUnit)
        return .manuallyFormatted(metric: convertedInput.value.formatted(.number.precision(.fractionLength(2))), unit: convertedInput.unit.symbol)
    }
    
    func formatIncline(_ input: Measurement<UnitAngle>) -> MetricWithUnit {
        let convertedInput = input.converted(to: inclineUnit)
        return .manuallyFormatted(metric: convertedInput.value.formatted(.number.precision(.fractionLength(2))), unit: convertedInput.unit.symbol)
    }
    
    func formatSpeed(_ input: Measurement<UnitSpeed>) -> MetricWithUnit {
        let convertedInput = input.converted(to: speedUnit)
        return .manuallyFormatted(metric: convertedInput.value.formatted(.number.precision(.fractionLength(2))), unit: convertedInput.unit.symbol)
    }
    
    func formatTime(_ input: Measurement<UnitDuration>) -> MetricWithUnit {
        let totalSeconds = Int(input.converted(to: .seconds).value)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let formattedTime: String
        
        if minutes >= 100 {
            formattedTime = String(format: "%d:%02d", minutes, seconds)
        } else {
            formattedTime = String(format: "%02d:%02d", minutes, seconds)
        }
        
        return .formattedByLocale(formattedTime)
    }
    
    /// Returns the formatted time needed to complete either 1 mile or km, based on configuration at the given speed
    func formatPace(at speed: Measurement<UnitSpeed>) -> MetricWithUnit {
        let distanceUnit = speedUnit == UnitSpeed.milesPerHour ? UnitLength.miles : .kilometers
        let speedUnit = speedUnit == UnitSpeed.milesPerHour ? UnitSpeed.milesPerHour : .kilometersPerHour
        
        let unitDistance = Measurement(value: 1, unit: distanceUnit)
        
        let timeInSeconds = unitDistance.value / speed.converted(to: speedUnit).value
        
        let timeMeasurement = Measurement(value: timeInSeconds, unit: UnitDuration.hours)
        
        return formatTime(timeMeasurement)
    }
    
    /// Converts the current distance into a track percentage
    func formatTrackPercentage(_ input: Measurement<UnitLength>) -> Double {
        let currentMiles = input.converted(to: .miles).value
        let trackMiles = trackDistance.converted(to: .miles).value
        
        let remainderCurrentMiles = currentMiles.truncatingRemainder(dividingBy: trackMiles)
        return remainderCurrentMiles / trackMiles
    }
    
    /// Converts a dictionary of unit-agnostic durations -> speeds into a dictionary of seconds -> configuration-set speed unit
    func formatSpeedForGraph(_ input: [Measurement<UnitDuration>: Measurement<UnitSpeed>]) -> [(Int, Double)] {
        return input.map { key, value in
            return (Int(key.converted(to: .seconds).value), value.converted(to: speedUnit).value)
        }.sorted { firstTuple, secondTuple in
            return firstTuple.0 < secondTuple.0
        }
    }
    
    /// Converts a dictionary of unit-agnostic durations -> inclines into a dictionary of seconds -> configuration-set incline unit
    func formatInclineForGraph(_ input: [Measurement<UnitDuration>: Measurement<UnitAngle>]) -> [(Int, Double)] {
        return input.map { key, value in
            return (Int(key.converted(to: .seconds).value), value.converted(to: inclineUnit).value)
        }.sorted { firstTuple, secondTuple in
            return firstTuple.0 < secondTuple.0
        }
    }
    
    func calculateSpeedAverageForGraph(_ input: [Measurement<UnitDuration>: Measurement<UnitSpeed>]) -> [(Int, Double)] {
        let averages = calculateAverages(input, zeroUnit: .init(value: 0, unit: .milesPerHour))
        
        return averages.map { second, speed in
            return (second, speed.converted(to: speedUnit).value)
        }
    }
    
    func calculateInclineAverageForGraph(_ input: [Measurement<UnitDuration>: Measurement<UnitAngle>]) -> [(Int, Double)] {
        let averages = calculateAverages(input, zeroUnit: .init(value: 0, unit: .degrees))
        
        return averages.map { second, incline in
            return (second, incline.converted(to: inclineUnit).value)
        }
    }
    
    /// Calculates the averages at every second from maxTime in input array back until maxTime - chartWidth
    private func calculateAverages<Metric: Dimension>(_ input: [Measurement<UnitDuration>: Measurement<Metric>], zeroUnit: Measurement<Metric>) -> [(Int, Measurement<Metric>)] {
        guard let maxSecond = input.keys.map({ Int($0.converted(to: .seconds).value) }).max() else {
            return []
        }
        
        let secondsToMetricArray = input.map { key, value in
            return (Int(key.converted(to: .seconds).value), value)
        }
        
        let secondsToMetric: [Int: Measurement<Metric>] = .init(secondsToMetricArray) { first, second in
            return (first + second) / 2
        }
        
        var currentMeasurement = zeroUnit
        var currentAverage = currentMeasurement
        var result: [(Int, Measurement<Metric>)] = []
        
        // We need to loop through every second because even seconds before chartWidth
        // need to be included in the average
        for second in stride(from: 0, to: maxSecond + 1, by: 1) {
            if let newMeasurement = secondsToMetric[second] {
                currentMeasurement = newMeasurement
            }
            
            // How much the current average needs to be weighted based
            let currentAverageWeight = (currentAverage * (Double(second) / Double(second + 1)))
            
            currentAverage = currentAverageWeight + currentMeasurement * (1.0 / Double(second + 1))
            
            result.append((second, currentAverage))
        }
        
        return result
    }
    
}
