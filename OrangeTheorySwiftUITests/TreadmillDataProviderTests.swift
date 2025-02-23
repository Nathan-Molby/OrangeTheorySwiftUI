//
//  TreadmillDataProviderTests.swift
//  OrangeTheorySwiftUITests
//
//  Created by Nathan Molby on 2/23/25.
//

import Testing
import Foundation
@testable import OrangeTheorySwiftUI

struct TreadmillDataProviderTests {
    
      private func duration(_ seconds: Double) -> Measurement<UnitDuration> {
          return Measurement(value: seconds, unit: .seconds)
      }
      
      private func speed(_ mps: Double) -> Measurement<UnitSpeed> {
          return Measurement(value: mps, unit: .metersPerSecond)
      }
      
      private func angle(_ degrees: Double) -> Measurement<UnitAngle> {
          return Measurement(value: degrees, unit: .degrees)
      }
      
      @Test
      func testEmptyHistoryAverageSpeed() {
          let provider = MockTreadmillDataProvider()
          #expect(provider.averageSpeed.value == 0)
      }
      
      @Test
      func testSingleEntryAverageSpeed() {
          let provider = MockTreadmillDataProvider(
              timeSinceStart: duration(10),
              speedHistory: [duration(0): speed(5)]
          )
          #expect(provider.averageSpeed.value == 5)
      }
      
      @Test
      func testBasicAverageSpeed() {
          let provider = MockTreadmillDataProvider(
              timeSinceStart: duration(30),
              speedHistory: [
                  duration(0): speed(2),
                  duration(10): speed(4),
                  duration(20): speed(6)
              ]
          )
          // Expected: (2*10 + 4*10 + 6*10) / 30 = 4
          #expect(provider.averageSpeed.value ~== 4)
      }
      
      @Test
      func testIrregularIntervalsAverageSpeed() {
          let provider = MockTreadmillDataProvider(
              timeSinceStart: duration(100),
              speedHistory: [
                  duration(0): speed(2),    // 2 m/s for 20s
                  duration(20): speed(4),   // 4 m/s for 30s
                  duration(50): speed(6)    // 6 m/s for 50s
              ]
          )
          // Expected: (2*20 + 4*30 + 6*50) / 100 = 4.6
          #expect(provider.averageSpeed.value ~== 4.6)
      }
      
      @Test
      func testEmptyHistoryAverageIncline() {
          let provider = MockTreadmillDataProvider()
          #expect(provider.averageIncline.value == 0)
      }
      
      @Test
      func testSingleEntryAverageIncline() {
          let provider = MockTreadmillDataProvider(
              timeSinceStart: duration(10),
              inclineHistory: [duration(0): angle(5)]
          )
          #expect(provider.averageIncline.value == 5)
      }
      
      @Test
      func testBasicAverageIncline() {
          let provider = MockTreadmillDataProvider(
              timeSinceStart: duration(30),
              inclineHistory: [
                  duration(0): angle(1),
                  duration(10): angle(2),
                  duration(20): angle(3)
              ]
          )
          // Expected: (1*10 + 2*10 + 3*10) / 30 = 2
          #expect(provider.averageIncline.value ~== 2)
      }
      
      @Test
      func testIrregularIntervalsAverageIncline() {
          let provider = MockTreadmillDataProvider(
              timeSinceStart: duration(100),
              inclineHistory: [
                  duration(0): angle(1),    // 1° for 20s
                  duration(20): angle(2),   // 2° for 30s
                  duration(50): angle(3)    // 3° for 50s
              ]
          )
          // Expected: (1*20 + 2*30 + 3*50) / 100 = 2.3
          #expect(provider.averageIncline.value ~== 2.3)
      }
      
      @Test
      func testOutOfOrderEntriesAverageSpeed() {
          let provider = MockTreadmillDataProvider(
              timeSinceStart: duration(30),
              speedHistory: [
                  duration(20): speed(6),
                  duration(0): speed(2),
                  duration(10): speed(4)
              ]
          )
          // Expected: (2*10 + 4*10 + 6*10) / 30 = 4
          #expect(provider.averageSpeed.value ~== 4)
      }
      
      @Test
      func testOutOfOrderEntriesAverageIncline() {
          let provider = MockTreadmillDataProvider(
              timeSinceStart: duration(30),
              inclineHistory: [
                  duration(20): angle(3),
                  duration(0): angle(1),
                  duration(10): angle(2)
              ]
          )
          // Expected: (1*10 + 2*10 + 3*10) / 30 = 2
          #expect(provider.averageIncline.value ~== 2)
      }
}
