//
//  TimeInterval+Ext.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/5/25.
//

import Foundation

extension TimeInterval {
    static func day(_ days: Int) -> TimeInterval {
        return .hour(24) * Double(days)
    }
    
    static func hour(_ hours: Int) -> TimeInterval {
        return .minute(60) * Double(hours)
    }
    
    static func minute(_ minutes: Int) -> TimeInterval {
        return .second(60) * Double(minutes)
    }
    
    static func minute(_ minutes: Double) -> TimeInterval {
        return .second(60) * minutes
    }
    
    static func second(_ seconds: Int) -> TimeInterval {
        return TimeInterval(seconds)
    }
    
    static func second(_ seconds: Double) -> TimeInterval {
        return TimeInterval(seconds)
    }
    
    static func millisecond(_ milliseconds: Double) -> TimeInterval {
        return TimeInterval(milliseconds / 1000)
    }
    
    var millisecond: Double {
        self * 1000
    }
    
    var seconds: Double {
        self
    }
     
    var minutes: Double {
        seconds / 60
    }
    
    var hours: Double {
        minutes / 60
    }
    
    var days: Double {
        hours / 24
    }
}
