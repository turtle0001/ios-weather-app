//
//  Forecast.swift
//  ios-weather-app
//
//  Created by joash.tubaga on 2/22/21.
//

import Foundation

struct Forecast: Codable {
    let daily:[Daily]
}

struct Daily: Codable {
    let dt: Date
    let temp: Temp
    let humidity: Int
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    
}

struct Temp: Codable {
    let min: Double
    let max: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}
