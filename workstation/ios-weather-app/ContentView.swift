//
//  ContentView.swift
//  ios-weather-app
//
//  Created by joash.tubaga on 2/22/21.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    @State private var location: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter Location", text: $location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        getWeatherForecast(for: location)
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title3)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Mobile Weather")
        }
    }
    
    func getWeatherForecast(for location: String) {
        let apiService = APIService.share
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=4bd0e96c46f2bf47c5fddbdd5807f3ed",
                                   dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast, APIService.APIError>) in
                    switch result {
                    case .success(let forecast):
                        for day in forecast.daily {
                            print(dateFormatter.string(from: day.dt))
                            print("   Max:  ", day.temp.max)
                            print("   Min:  ", day.temp.min)
                            print("   Humidity:  ", day.humidity)
                            print("   Description:  ", day.weather[0].description)
                            print("   Clouds:  ", day.clouds)
                            print("   Pop:  ", day.pop)
                            print("   IconURL:  ", day.weather[0].weatherIconURL)
                        }
                    case.failure(let apiError):
                        switch apiError {
                        case.error(let errorString):
                            print(errorString)
                        }
                    }
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
