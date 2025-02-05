//
//  RoughlyEquals.swift
//  OrangeTheorySwiftUITests
//
//  Created by Nathan Molby on 2/4/25.
//

import Foundation

infix operator ~==


extension Double {
    static func ~==(lhs: Double, rhs: Double) -> Bool {
        return fabs(lhs - rhs) < Double.ulpOfOne
    }
}
