//
//  BiometricsDataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/8/25.
//

import Foundation

protocol BiometricsDataProvider {
    /// Workout duration in seconds
    var timeSinceStart: TimeInterval { get }
    
    /// Maximum heart rate in beats per minute (BPM)
    var maxHeartRate: Double { get }
    
    /// Current heart rate in beats per minute (BPM)
    var currentHeartRate: Double { get }
    
    /// Current heart rate as a percentage of max heart rate
    var currentHeartRatePercentage: Double { get }
    
    /// Total calories burned
    var caloriesBurnt: Double { get }
    
    /// Points earned for each minute at 84%+ of max heart rate (Orange and Red zones)
    var splatPoints: Double { get }
    
    /// Name of the user
    var name: String { get }
}

extension BiometricsDataProvider {
    var heartRateZone: HeartRateZone {
        return .init(heartRatePercentage: currentHeartRate / maxHeartRate)
    }
}
