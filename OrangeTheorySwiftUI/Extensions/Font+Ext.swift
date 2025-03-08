//
//  Font+Ext.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/9/25.
//

import SwiftUI

fileprivate let fontBold = "LEMONMILK-Bold"
fileprivate let fontRegular = "LEMONMILK-Regular"
fileprivate let fontLight = "LEMONMILK-Light"

extension Font {
    static let heartRateFont = Font.custom(fontRegular, size: 90, relativeTo: .largeTitle)
    
    static let largest = Font.custom(fontRegular, size: 70, relativeTo: .largeTitle)
    static let largestLight = Font.custom(fontLight, size: 70, relativeTo: .largeTitle)
    
    static let large = Font.custom(fontRegular, size: 50, relativeTo: .largeTitle)
    static let largeLight = Font.custom(fontLight, size: 50, relativeTo: .largeTitle)
    
    static let medium = Font.custom(fontRegular, size: 30, relativeTo: .headline)
    static let mediumLight = Font.custom(fontLight, size: 30, relativeTo: .headline)
    
    static let small = Font.custom(fontRegular, size: 20, relativeTo: .headline)
    static let smallLight = Font.custom(fontLight, size: 20, relativeTo: .headline)
}
