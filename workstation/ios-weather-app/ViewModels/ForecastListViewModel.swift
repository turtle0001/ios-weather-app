//
//  ForecastListViewModel.swift
//  ios-weather-app
//
//  Created by joash.tubaga on 2/22/21.
//

import CoreLocation
import Foundation

class ForecastListViewModel: ObservableObject {
    
    @Published var forecasts: [ForecastViewModel] = []
    
    var location: String = ""
    
    func getWeatherForecast() {
        let apiService = APIService.share
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
                        DispatchQueue.main.async {
                            self.forecasts = forecast.daily.map { ForecastViewModel(dailyForecast: $0)}
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
