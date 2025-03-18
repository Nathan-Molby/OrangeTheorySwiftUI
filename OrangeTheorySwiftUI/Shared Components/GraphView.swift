//
//  GraphView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/11/25.
//

import SwiftUI
import Charts

struct GraphConfiguration {
    let yMarkers: [Double]
    let yMarkerSuffix: String?
    
    var scale: ClosedRange<Double> {
        let lastValue = yMarkers.last ?? 0
        if lastValue < 1 {
            return 0...(lastValue + 0.01)
        } else {
            return 0...(lastValue + 1)
        }
    }
}

struct GraphView<M: Dimension>: View {
    let metricBySecond: [(Int, Double)]
    let averageBySecond: [(Int, Double)]
    let configuration: GraphConfiguration
    
    init(metricBySecond: [(Int, Double)], averageBySecond: [(Int, Double)], configuration: GraphConfiguration) {
        self.metricBySecond = metricBySecond
        self.averageBySecond = averageBySecond
        self.configuration = configuration
    }
    
    @Environment(\.configuration.chartWidthMinutes) var chartWidth
    
    func averageAt(_ second: Int) -> Double? {
        return averageBySecond.first(where: { $0.0 == second })?.1
    }
    
    var averagesInChartWidth: [(Int, Double)] {
        averageBySecond.filter { chartXScale.contains($0.0) }
    }
    
    var metricsInChartWidth: [(Int, Double)] {
        metricBySecond.filter { chartXScale.contains($0.0) }
    }
    
    var chartXScale: ClosedRange<Int> {
        let maxInputSecond = averageBySecond.last?.0 ?? 0
        let chartMax = max(maxInputSecond, Int(chartWidth) * 60)
        let chartMin = max(0, chartMax - Int(chartWidth) * 60)
        
        return chartMin...chartMax
    }

    var body: some View {
        Chart {
            ForEach(averagesInChartWidth, id: \.0) { (secondOnChart, averageAtSecond) in
                AreaMark(x: .value("Second", secondOnChart), y: .value("Average", averageAtSecond))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .chartForeground,
                                .chartSecondary
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                LineMark(x: .value("Second", secondOnChart), y: .value("Average", averageAtSecond), series: .value("Average", "A"))
                    .foregroundStyle(.accent)
                    .lineStyle(.init(lineWidth: 10))
            }
            
            ForEach(metricsInChartWidth, id: \.0) { second, metric in
                LineMark(x: .value("Second", second), y: .value("Metric", metric))
                    .foregroundStyle(.white)
                    .lineStyle(.init(lineWidth: 7))
            }
        }
        .chartXAxis(.hidden)
        .chartYScale(domain: configuration.scale)
        .chartXScale(domain: chartXScale)
        .chartYAxis {
            AxisMarks(position: .trailing, values: configuration.yMarkers) { value in
                if let value = value.as(Double.self) {
                    AxisValueLabel {
                        Text("\(value.formatted())\(configuration.yMarkerSuffix ?? "")")

                    }
                    .font(.medium.bold())
                    .foregroundStyle(.white)
                }
                
                AxisGridLine()
                    .foregroundStyle(.white)
            }
        }

    }
}

#Preview("Speed") {
    let speedHistory = PreviewTreadmillDataProvider().speedHistory
    let formattedSpeedHistory = Configuration().formatSpeedForGraph(speedHistory)
    let averageSpeedHistory = Configuration().calculateSpeedAverageForGraph(speedHistory)
    
    GraphView(metricBySecond: formattedSpeedHistory, averageBySecond: averageSpeedHistory, configuration: GraphConfiguration(yMarkers: [3, 6, 9, 12], yMarkerSuffix: nil))
        .environment(\.configuration.chartWidthMinutes, 10)
        .frame(height: 400)
}
