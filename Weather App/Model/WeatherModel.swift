//
//  WeatherModel.swift
//  Weather App
//
//  Created by macbook  on 26/03/21.
//  Copyright © 2021 Almaalik. All rights reserved.
//

import Foundation


///Weather Condition details
struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let longitude: Double
    let latitude: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var array: Int {
    switch conditionId {
    case 200...299:
        return 0
    case 300...400:
        return 1
    case 400...499:
        return 2
    case 500...599:
        return 3
    case 600...700:
        return 4
    case 701...800:
        return 5
    default:
        return 6
    }
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
          return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"

        case 500...531:
            return "cloud.rain"

        case 600...622:
            return "cloud.snow"

        case 701...781:
           return "cloud.fog"

        case 800:
            return "sun.max"

        case 801...804:
            return "cloud.bolt"

        default:
            return "cloud"

        }
    }

}

struct DataModel {
    let Date: Double
    let timezone: String
    
}

