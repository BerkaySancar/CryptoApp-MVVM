//
//  ChartView.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 7.02.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @Binding var prices: [Price]
    var currentPrice: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Price Chart")
                .foregroundStyle(.white)
            Chart {
                RuleMark(y: .value("Current", currentPrice))
                    .foregroundStyle(.white)
                    .lineStyle(.init(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .leading) {
                        Text("current price")
                            .font(.footnote)
                            .foregroundStyle(.white)
                    }
                
                ForEach(prices) { price in
                    LineMark(
                        x: .value("Day", price.day, unit: .day),
                        y: .value("Prices", price.price)
                    )
                    .interpolationMethod(.linear)
                    .foregroundStyle(Color.appYellow.opacity(1).gradient)
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .month))
                { date in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.month(), centered: false)
                }
            }
            .foregroundStyle(.white)
            .frame(height: 200)
        }
        .padding()
    }
}


//#Preview {
//    ChartView()
//}
