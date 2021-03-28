//
//  WeatherTime.swift
//  Weather App
//
//  Created by macbook  on 26/03/21.
//  Copyright © 2021 Almaalik. All rights reserved.
//

import Foundation

import CoreLocation

protocol WeatherTimeDelegate {
    
    func didUpdateWeather(_ weatherTime: WeatherTime, weatherData: DataModel)
    func didFailWithError(error: Error)
}
///Getting Time and Date
struct WeatherTime {
    let timeURL = "https://api.openweathermap.org/data/2.5/onecall?lat"
    
  var delegate: WeatherTimeDelegate?
    
    func timeData(longitude: Double, latitude: Double) {
        let timeString = "\(timeURL)=\(latitude)&lon=\(longitude)&appid=aaa378e239c2915a1fc61b6528616289"
        performRequest(with: timeString)
       // print(timeString)
    }
    
func performRequest(with timeString: String) {
            if let url = URL(string: timeString) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    if let safeData = data {
                        if let TimeData = self.parseJSON(safeData) {
                           // self.delegate?.didUpdateWeather(self, weatherData: weather)
                            self.delegate?.didUpdateWeather(self, weatherData: TimeData)
                        }
                    }
                }
                task.resume()
            }
    
        }
    ///Decoding the Date and Time details for the search location
    func parseJSON(_ timeData: Data) -> DataModel? {
        
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(TimeData.self, from: timeData)
              let date = decodedData.current.dt
              let timezone = decodedData.timezone
  
              let weather = DataModel(Date: date, timezone: timezone)
    
            return weather
    
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
   
}




