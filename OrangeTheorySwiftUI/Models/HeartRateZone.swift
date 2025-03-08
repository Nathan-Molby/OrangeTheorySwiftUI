//
//  HeartRateZone.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/8/25.
//

import Foundation
import SwiftUI

enum HeartRateZone: Identifiable, CaseIterable {
    case gray
    case blue
    case green
    case orange
    case red
    
    init(heartRatePercentage: Double) {
        switch heartRatePercentage {
        case ..<0.6:
            self = .gray
        case 0.6..<0.7:
            self = .blue
        case 0.7..<0.83:
            self = .green
        case 0.83..<0.91:
            self = .orange
        default:
            self = .red
        }
    }
    
    var displayValue: String {
        switch self {
        case .gray:
            "Gray"
        case .blue:
            "Blue"
        case .green:
            "Green"
        case .orange:
            "Orange"
        case .red:
            "Red"
        }
    }
    
    var color: Color {
        switch self {
        case .gray:
            Color.grayZone
        case .blue:
            Color.blueZone
        case .green:
            Color.greenZone
        case .orange:
            Color.orangeZone
        case .red:
            Color.redZone
        }
    }
    
    var id: HeartRateZone {
        self
    }
}
