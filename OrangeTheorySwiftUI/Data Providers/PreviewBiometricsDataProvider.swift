//
//  PreviewBiometricsDataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/8/25.
//

import Foundation

struct PreviewBiometricsDataProvider: BiometricsDataProvider {
    var timeSinceStart: TimeInterval = .minute(15)
    
    var maxHeartRate: Double = 195
    
    var currentHeartRate: Double = 165
    
    var currentHeartRatePercentage: Double = 84.6
    
    var caloriesBurnt: Double = 267.5
    
    var splatPoints: Double = 8.5
    
    var name: String = "Nathan M"
}
