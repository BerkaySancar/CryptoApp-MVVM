//
//  CoinDetailView.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 7.02.2024.
//

import SwiftUI
import Charts

struct CoinDetailView: View {
    
    @StateObject var viewModel: CoinDetailViewModel
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            if viewModel.coin != nil {
                ScrollView {
                    VStack {
                        //MARK: Header
                        HStack {
                            AsyncImage(url: URL(string: viewModel.coinImage)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(viewModel.name ?? "")
                                        .font(.title2.bold())
                                        .lineLimit(1)
                                    Text("(\(viewModel.symbol ?? ""))")
                                        .font(.title2)
                                }
                                Text("$" + String(describing: viewModel.currentPrice ?? 0))
                                    .font(.title2)
                            }
                            .foregroundStyle(.white)
                            Spacer()
                            Text(String(describing: viewModel.priceChangeCPercentage24h ?? ""))
                                .foregroundStyle(.white)
                                .font(.headline.bold())
                                .padding(.horizontal)
                                .padding(.vertical, 2)
                                .background(viewModel.isPriceChangePositive ? .green : .red)
                                .clipShape(.rect(cornerRadius: 26))
                        }
                        .padding(16)
                        
                        //MARK: Triple Info Buttons
                        HStack {
                            VStack {
                                Text("High (24h)")
                                Text("$" + String(describing: viewModel.high24h ?? 0))
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .background(.cellBackground)
                            .clipShape(.rect(cornerRadius: 16))
                            
                            Spacer()
                            
                            VStack {
                                Text("Low (24h)")
                                Text("$" + String(describing: viewModel.low24h ?? 0))
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .background(.cellBackground)
                            .clipShape(.rect(cornerRadius: 16))
                            
                            Spacer()
                            VStack {
                                Text("Average")
                                Text("$" + String(describing: viewModel.average24h ?? 0))
                                    .lineLimit(1)
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .background(.cellBackground)
                            .clipShape(.rect(cornerRadius: 16))
                        }
                        .padding(10)
                        
                        //MARK: CHART
                        ChartView(prices: $viewModel.prices, currentPrice: viewModel.currentPrice ?? 0)
                        
                        //MARK: CoinDetailDescription
                        VStack(alignment: .leading) {
                            Text(viewModel.coinDetailDescription)
                                .foregroundStyle(.white)
                            Button("Tap to see \(viewModel.coin?.name ?? "") official homepage on  Safari.") {
                                viewModel.homepageTapped()
                            }
                            .foregroundStyle(.appYellow)
                            .frame(maxWidth: .infinity)
                        }
                        .padding(8)
                        
                        //MARK: Ath Atl AthDate AtlDate
                        HStack {
                            Spacer()
                            
                            VStack {
                                Text("ATH")
                                    .font(.title2)
                                Text("$" + (viewModel.ath ?? ""))
                                Text(viewModel.athDate ?? "")
                                    .foregroundStyle(.appYellow)
                                    .font(.footnote)
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .background(.cellBackground)
                            .clipShape(.rect(cornerRadius: 16))
                            
                            Spacer()
                            
                            VStack {
                                Text("ATL")
                                    .font(.title2)
                                Text("$" + (viewModel.atl ?? ""))
                                Text(viewModel.atlDate ?? "")
                                    .font(.footnote)
                                    .foregroundStyle(.appYellow)
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .background(.cellBackground)
                            .clipShape(.rect(cornerRadius: 16))
                            
                            Spacer()
                        }
                        .padding(10)
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.favButtonTapped()
                        } label: {
                            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                .foregroundStyle(.appYellow)
                        }
                    }
                }
            }
        }
    }
}
