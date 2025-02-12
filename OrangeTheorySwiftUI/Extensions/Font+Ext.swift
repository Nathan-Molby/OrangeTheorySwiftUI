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
    static let largest = Font.custom(fontRegular, size: 70, relativeTo: .largeTitle)
    static let largestLight = Font.custom(fontLight, size: 70, relativeTo: .largeTitle)
    
    static let medium = Font.custom(fontRegular, size: 30, relativeTo: .headline)
    static let mediumBold = Font.custom(fontBold, size: 30, relativeTo: .headline)
    static let mediumLight = Font.custom(fontLight, size: 30, relativeTo: .headline)
    
    
}
