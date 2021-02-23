//
//  ContentView.swift
//  ios-weather-app
//
//  Created by joash.tubaga on 2/22/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct ContentView: View {
    
    @StateObject private var forecastListViewModel = ForecastListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $forecastListViewModel.system, label: Text("System")) {
                    Text("°C").tag(0)
                    Text("°F").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                .padding(.vertical)
                HStack {
                    TextField("Enter Location", text: $forecastListViewModel.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        forecastListViewModel.getWeatherForecast()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title3)
                    }
                }
                List(forecastListViewModel.forecasts, id: \.day) { day in
                        VStack(alignment: .leading) {
                            Text(day.day)
                                .fontWeight(.bold)
                            HStack(alignment: .center) {
                                WebImage(url: day.weatherIconURL)
                                    .resizable()
                                    .placeholder {
                                        Image(systemName: "hourglass")
                                    }
                                    .scaledToFit()
                                    .frame(width: 75)
                                VStack(alignment: .leading) {
                                    Text(day.overview)
                                    HStack {
                                        Text(day.high)
                                        Text(day.low)
                                    }
                                    HStack {
                                        Text(day.clouds)
                                        Text(day.pop)
                                    }
                                    Text(day.humidity)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
            }
            .padding(.horizontal)
            .navigationTitle("Mobile Weather")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
