//
//  WeatherModel.swift
//  13.Clima
//
//  Created by Oleksandr Kachkin on 21.02.2022.
//

import Foundation

struct WeatherModel {
  let conditionId: Int
  let cityName: String
  let temperature: Double
  
  var temperatureString: String {
    return String(format: "%.0f", temperature)
  }
  
  var conditionName: String {
    switch conditionId {
    case 200...223 : return "cloud.bolt"
    case 300...321 : return "cloud.drizzle"
    case 500...531 : return "cloud.rain"
    case 600...622 : return "cloud.snow"
    case 700,711,721,731,741,751,761,762,771,781 : return "cloud.fog"
    case 800 : return "sun.max"
    case 801...804 : return "cloud"
    default: return "cloud"
    }
  }
}
