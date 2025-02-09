//
//  EnvironmentValues+Ext.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var treadmillDataProvider: TreadmillDataProvider = PreviewTreadmillDataProvider()
    
    @Entry var configuration = Configuration()
}
