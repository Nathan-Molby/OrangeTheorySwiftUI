//
//  SupportedLengthUnit.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/5/25.
//

import Foundation

enum SupportedLengthUnit: CaseIterable, Identifiable {
    case mile
    case kilometer
    case meter
    case furlong
    
    var unitLength: UnitLength {
        switch self {
        case .mile:
            return .miles
        case .kilometer:
            return .kilometers
        case .meter:
            return .meters
        case .furlong:
            return .furlongs
        }
    }
    
    var displayName: String {
        switch self {
        case .mile:
            return "Mile"
        case .kilometer:
            return "Kilometer"
        case .meter:
            return "Meter"
        case .furlong:
            return "Furlong"
        }
    }
    
    var id: Self {
        self
    }
}
