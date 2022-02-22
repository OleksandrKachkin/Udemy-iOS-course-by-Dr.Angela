//
//  WeatherViewController.swift
//  13.Clima
//
//  Created by Oleksandr Kachkin on 17.02.2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  
  // объект Weather Manager способный извлекает данные в реальном времени
  var weatherManager = WeatherManager()
  // locationManager будет нести ответственность за получение текущего местоположения телефона по GPS.
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
    
    weatherManager.delegate = self
    searchTextField.delegate = self
  }
  
  @IBAction func locationButtonPressed(_ sender: UIButton) {
    locationManager.requestLocation()
  }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
  
  @IBAction func searchPressed(_ sender: UIButton) {
    searchTextField.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.endEditing(true)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      textField.placeholder = "Type something"
      return false
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    if let city = searchTextField.text {
      weatherManager.fetchWeather(cityName: city)
    }
    
    searchTextField.text = ""
  }
  
  func didUpdateWeather(weather: WeatherModel) {
    print(weather.temperatureString)
  }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
  
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
    DispatchQueue.main.async {
      self.conditionImageView.image = UIImage(systemName: weather.conditionName)
      self.temperatureLabel.text = weather.temperatureString
      self.cityLabel.text = weather.cityName
    }
  }
  
  func didFailWithError(error: Error) {
    print(error)
  }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      locationManager.stopUpdatingLocation()
      let lat = location.coordinate.latitude
      let lon = location.coordinate.longitude
      weatherManager.fetchWeather(latitude: lat, longitude: lon)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}

