//
//  UnitDistance+Ext.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import Foundation

extension Measurement {
    static func *(lhs: Measurement<UnitSpeed>, rhs: Measurement<UnitDuration>) -> Measurement<UnitLength> {
        let currentSpeed = lhs.converted(to: .metersPerSecond).value
        let currentDuration = rhs.converted(to: .seconds).value
        return .init(value: currentSpeed * currentDuration, unit: .meters)
    }
    
    static func *(lhs: Measurement<UnitDuration>, rhs: Measurement<UnitSpeed>) -> Measurement<UnitLength> {
        rhs * lhs
    }
    
    static func += (lhs: inout Measurement<UnitLength>, rhs: Measurement<UnitLength>) {
        let newValue = lhs.converted(to: .meters).value + rhs.converted(to: .meters).value
        lhs = .init(value: newValue, unit: .meters)
    }
}
