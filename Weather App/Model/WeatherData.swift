//
//  WeatherData.swift
//  Weather App
//
//  Created by macbook  on 26/03/21.
//  Copyright © 2021 Almaalik. All rights reserved.
//

import Foundation
///Weather Data from OpenWeatherMap API
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct TimeData: Codable {
     let timezone: String
     let current:  Current
}
struct Current: Codable {
    let dt: Double
}

