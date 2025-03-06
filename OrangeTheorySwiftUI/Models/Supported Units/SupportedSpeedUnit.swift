//
//  SupportedSpeedUnit.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/5/25.
//

import Foundation

enum SupportedSpeedUnit: CaseIterable, Identifiable {
    case milesPerHour
    case kilometersPerHour
    case metersPerSecond
    
    var unitSpeed: UnitSpeed {
        switch self {
        case .milesPerHour:
            return .milesPerHour
        case .kilometersPerHour:
            return .kilometersPerHour
        case .metersPerSecond:
            return .metersPerSecond
        }
    }
    
    var displayName: String {
        switch self {
        case .milesPerHour:
            "Miles Per Hour"
        case .kilometersPerHour:
            "Kilometers Per Hour"
        case .metersPerSecond:
            "Meters Per Second"
        }
    }
    
    var id: Self { self }
}
