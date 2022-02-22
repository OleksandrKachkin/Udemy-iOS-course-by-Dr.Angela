//
//  WeatherData.swift
//  13.Clima
//
//  Created by Oleksandr Kachkin on 18.02.2022.
//

import Foundation

struct WeatherData: Codable {
  let name: String
  let main: Main
  let weather: [Weather]
}

struct Main: Codable {
  let temp: Double
}

struct Weather: Codable {
  let description: String
  let id: Int
}
