//
//  WeatherManager.swift
//  13.Clima
//
//  Created by Oleksandr Kachkin on 18.02.2022.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
  //  Метод обновляет интерфейс
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
  // Метод обрабатывает/передает ошибки
  func didFailWithError(error: Error)
}

struct WeatherManager {
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5250c01ffb413291b7a6df6423832cc7&units=metric"
  
  // делегат будет обладать методом "didUpdateWeather"
  var delegate: WeatherManagerDelegate?
  
  func fetchWeather(cityName: String) {
    let urlString = "\(weatherURL)&q=\(cityName)"
    performRequest(with: urlString)
  }
  
  func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
    performRequest(with: urlString)
  }
  
  func performRequest(with urlString: String) {
    
    // 1. Create a URL object
    if let url = URL(string: urlString) {
      
      // 2. Create a URLSession
      let session = URLSession(configuration: .default)
      
      // 3. Give the session a task
      let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          self.delegate?.didFailWithError(error: error!)
          return
        }
        if let safeData = data {
          if let weather = self.parseJSON(safeData) {
            // Передать weather в WeatherViewController, используя delegate pattern
            self.delegate?.didUpdateWeather(self, weather: weather)
          }
        }
      }
      
      // 4. Start the task - Недавно инициализированные задачи (наш task) начинаются в приостановленном состоянии (suspended state), поэтому нужно вызвать этот метод, чтобы запустить задачу.
      task.resume()
    }
  }
  
  
  
  func parseJSON(_ weatherData: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
      let id = decodedData.weather[0].id
      let temp = decodedData.main.temp
      let name = decodedData.name
      let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
      return weather
      
    } catch {
      delegate?.didFailWithError(error: error)
      return nil
    }
  }
  
  
  
}
