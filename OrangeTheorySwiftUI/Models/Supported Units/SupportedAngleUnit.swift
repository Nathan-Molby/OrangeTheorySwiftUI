//
//  SupportedAngleUnit.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/5/25.
//

import Foundation

enum SupportedAngleUnit: CaseIterable, Identifiable {
    case incline
    case degrees
    case radians
    
    var unitAngle: UnitAngle {
        switch self {
        case .incline:
            return .incline
        case .degrees:
            return .degrees
        case .radians:
            return .radians
        }
    }
    
    var displayName: String {
        switch self {
        case .incline:
            return "Incline"
        case .degrees:
            return "Degrees"
        case .radians:
            return "Radians"
        }
    }
    
    var id: Self { self }
}
