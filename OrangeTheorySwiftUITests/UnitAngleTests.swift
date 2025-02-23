//
//  OrangeTheorySwiftUITests.swift
//  OrangeTheorySwiftUITests
//
//  Created by Nathan Molby on 2/4/25.
//

import Testing
import Foundation
@testable import OrangeTheorySwiftUI

struct OrangeTheorySwiftUITests {
    
    @Test(arguments: Array(stride(from: 0, to: 100, by: 1)))
    func testConversionFromIncline(inputIncline: Double)  {
        let incline: Measurement<UnitAngle> = .init(value: inputIncline, unit: .incline)
                
        #expect(incline.converted(to: .radians).value ~== atan(inputIncline / 100))
    }
    
    @Test(arguments: Array(stride(from: 0, to: 360, by: 1)))
    func testConversionToIncline(degrees: Double) {
        let degrees: Measurement<UnitAngle> = .init(value: degrees, unit: .degrees)
        
        let expectation = tan(degrees.converted(to: .radians).value) * 100
        
        #expect(degrees.converted(to: .incline).value ~== expectation)
    }

}
