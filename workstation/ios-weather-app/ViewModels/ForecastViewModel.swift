//
//  ForecastViewModel.swift
//  ios-weather-app
//
//  Created by joash.tubaga on 2/22/21.
//

import Foundation

struct ForecastViewModel {
    let dailyForecast: Daily
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    var day: String {
        return Self.dateFormatter.string(from: dailyForecast.dt)
    }
    
    var overview: String {
        dailyForecast.weather[0].description.capitalized
    }
    
    var high: String {
        return "H: \(Self.numberFormatter.string(from: NSNumber(value: dailyForecast.temp.max)) ?? "0")°"
    }
    
    var low: String {
        return "L: \(Self.numberFormatter.string(from: NSNumber(value: dailyForecast.temp.min)) ?? "0")°"
    }
    
    var pop: String {
        return "💧 \(Self.numberFormatter2.string(from: NSNumber(value: dailyForecast.pop)) ?? "0%")"
    }
    
    var clouds: String {
        return "☁️ \(dailyForecast.clouds)%"
    }
    
    var humidity: String {
        return "Humidity: \(dailyForecast.humidity)%"
    }
}
