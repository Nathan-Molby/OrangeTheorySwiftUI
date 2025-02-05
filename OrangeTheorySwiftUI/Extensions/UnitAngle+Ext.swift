//
//  UnitAngle+Ext.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import Foundation

class InclineUnitConverter: UnitConverter {
    override func baseUnitValue(fromValue value: Double) -> Double {
        let radians = atan(value / 100)
        return Measurement<UnitAngle>(value: radians, unit: .radians).converted(to: .degrees).value
    }
    
    override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
        let radiansInputValue = Measurement<UnitAngle>(value: baseUnitValue, unit: .degrees).converted(to: .radians).value
        
        return tan(radiansInputValue) * 100
    }
}

extension UnitAngle {
    static let incline = UnitAngle(symbol: "%", converter: InclineUnitConverter())
}
