//
//  Configuration.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/9/25.
//

import Foundation

struct Configuration {
    var lengthUnit: SupportedLengthUnit = .mile {
        didSet {
            trackDistance = trackDistance.converted(to: lengthUnit.unitLength)
        }
    }
    var speedUnit: SupportedSpeedUnit = .milesPerHour
    var inclineUnit: SupportedAngleUnit = .incline
    var trackDistance: Measurement<UnitLength> = .init(value: 0.5, unit: .miles)
    var chartWidthMinutes = 5.0
    
    var inclineYAxis: [Double] {
        let valuesWhenUnitIsIncline = [5.0, 10, 15]
        
        return valuesWhenUnitIsIncline
            .map {
                let valueInIncline = Measurement<UnitAngle>(value: $0, unit: .incline)
                
                return valueInIncline.converted(to: inclineUnit.unitAngle)
                    .value
            }
    }
    
    var speedYAxis: [Double] {
        let valuesWhenUnitIsMph = [3.0, 6, 9, 12]
        
        return valuesWhenUnitIsMph
            .map {
                let valueInIncline = Measurement<UnitSpeed>(value: $0, unit: .milesPerHour)
                
                return valueInIncline.converted(to: speedUnit.unitSpeed)
                    .value
            }
    }
    
    func formatLength(_ input: Measurement<UnitLength>) -> MetricWithUnit {
        let convertedInput = input.converted(to: lengthUnit.unitLength)
        return .manuallyFormatted(metric: convertedInput.value.formatted(.number.precision(.fractionLength(2))), unit: convertedInput.unit.symbol)
    }
    
    func formatIncline(_ input: Measurement<UnitAngle>) -> MetricWithUnit {
        let convertedInput = input.converted(to: inclineUnit.unitAngle)
        return .manuallyFormatted(metric: convertedInput.value.formatted(.number.precision(.fractionLength(2))), unit: convertedInput.unit.symbol)
    }
    
    func formatSpeed(_ input: Measurement<UnitSpeed>) -> MetricWithUnit {
        let convertedInput = input.converted(to: speedUnit.unitSpeed)
        return .manuallyFormatted(metric: convertedInput.value.formatted(.number.precision(.fractionLength(2))), unit: convertedInput.unit.symbol)
    }
    
    func formatTime(_ input: TimeInterval) -> MetricWithUnit {
        let minutes = Int(input) / 60
        let seconds = Int(input) % 60
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
        let distanceUnit = speedUnit == .milesPerHour ? UnitLength.miles : .kilometers
        let speedUnit = speedUnit == .milesPerHour ? UnitSpeed.milesPerHour : .kilometersPerHour
        
        let unitDistance = Measurement(value: 1, unit: distanceUnit)
        
        let timeInHours = unitDistance.value / speed.converted(to: speedUnit).value
        
        let timeMeasurement = Measurement(value: timeInHours, unit: UnitDuration.hours)
        
        return formatTime(timeMeasurement.converted(to: .seconds).value)
    }
    
    /// Converts the current distance into a track percentage
    func formatTrackPercentage(_ input: Measurement<UnitLength>) -> Double {
        let currentMiles = input.converted(to: .miles).value
        let trackMiles = trackDistance.converted(to: .miles).value
        
        let remainderCurrentMiles = currentMiles.truncatingRemainder(dividingBy: trackMiles)
        return remainderCurrentMiles / trackMiles
    }
    
    /// Converts an array of unit-agnostic durations -> speeds into a dictionary of seconds -> configuration-set speed unit
    func formatSpeedForGraph(_ input: [(TimeInterval, Measurement<UnitSpeed>)]) -> [(Int, Double)] {
        return input.map { time, speed in
            return (lround(time), speed.converted(to: speedUnit.unitSpeed).value)
        }
    }
    
    /// Converts an array of unit-agnostic durations -> inclines into an array of seconds -> configuration-set incline unit
    func formatInclineForGraph(_ input: [(TimeInterval, Measurement<UnitAngle>)]) -> [(Int, Double)] {
        return input.map { time, angle in
            return (lround(time), angle.converted(to: inclineUnit.unitAngle).value)
        }
    }
    
    func calculateSpeedAverageForGraph(_ input: [(TimeInterval, Measurement<UnitSpeed>)]) -> [(Int, Double)] {
        let averages = calculateAverages(input, zeroUnit: .init(value: 0, unit: .milesPerHour))
        
        return averages.map { second, speed in
            return (lround(second), speed.converted(to: speedUnit.unitSpeed).value)
        }
    }
    
    func calculateInclineAverageForGraph(_ input: [(TimeInterval, Measurement<UnitAngle>)]) -> [(Int, Double)] {
        let averages = calculateAverages(input, zeroUnit: .init(value: 0, unit: .degrees))
        
        return averages.map { second, incline in
            return (lround(second), incline.converted(to: inclineUnit.unitAngle).value)
        }
    }
    
    /// Calculates the averages at every second from maxTime in input array back until maxTime - chartWidth
    private func calculateAverages<Metric: Dimension>(_ input: [(TimeInterval, Measurement<Metric>)], zeroUnit: Measurement<Metric>) -> [(Double, Measurement<Metric>)] {
        guard !input.isEmpty else { return [] }
        
        var result: [(Double, Measurement<Metric>)] = []
        var currentAverage = input[0].1
        
        for (index, (timeInterval, measurement)) in input.enumerated() {
            let weight = 1.0 / Double(index + 1)
            currentAverage = currentAverage * (1 - weight) + measurement * weight
            result.append((timeInterval, currentAverage))
        }
        
        return result
    }
    
}
