//
//  WeatherViewController.swift
//  Weather App
//
//  Created by macbook  on 26/03/21.
//  Copyright © 2021 Almaalik. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var background: UIImageView!
    @IBAction func searchPressed(_ sender: UIButton) {
        searchForLocation()
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        currentLocation()
    }
    ///Corresponding background images based on weather condition
 var weatherTime = WeatherTime()
    var weatherManager = WeatherManager()
       let locationManager = CLLocationManager()
        let imageArray = [ #imageLiteral(resourceName: "Bolt") ,#imageLiteral(resourceName: "Drizzle") , #imageLiteral(resourceName: "Rain") , #imageLiteral(resourceName: "Snow") , #imageLiteral(resourceName: "Fog") , #imageLiteral(resourceName: "Sun") , #imageLiteral(resourceName: "Cloud") ]
        
       override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        weatherTime.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
       }
}

///Searching User required location data
    extension WeatherViewController: UITextFieldDelegate {
    
        private func searchForLocation() {
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
}

        
                //MARK: - WeatherManagerDelegate
///Updating the UI
        
                extension WeatherViewController: WeatherManagerDelegate {
        
                    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
                        DispatchQueue.main.async {
                            self.temperatureLabel.text = weather.temperatureString
                           
                                self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                                let bgimage = weather.array
                                self.background.image = self.imageArray[bgimage]
                             
                                let longi = weather.longitude
                                let lati = weather.latitude
                             
                                self.weatherTime.timeData(longitude: longi,latitude: lati)
                       
                                self.cityLabel.text = weather.cityName
                        }
                    }
        
                    func didFailWithError(error: Error) {
                        print(error)
                    }
                }

 ///Users location
        extension WeatherViewController: CLLocationManagerDelegate {
    
            private func currentLocation() {
            locationManager.requestLocation()
            }
                    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                        if let location = locations.last {
                            locationManager.stopUpdatingLocation()
                            let lat = location.coordinate.latitude
                            let lon = location.coordinate.longitude
                            weatherManager.fetchWeather(latitude: lat, longitude: lon)
                        }
                    }
        
                    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                        print("error in finding the current loacation:\(error)")
                    }
                }
    
///Date and Time formetter

    extension WeatherViewController: WeatherTimeDelegate {

        func didUpdateWeather(_ weatherTime: WeatherTime, weatherData: DataModel) {
            
               DispatchQueue.main.async {

                print("Timezone: \(weatherData.timezone)")
                
                let unixDate: TimeInterval = weatherData.Date
                let usableDate = Date(timeIntervalSince1970: unixDate)

                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .medium
                var dateString = dateFormatter.string(from: usableDate)

                let timezone = TimeZone(identifier: "\(weatherData.timezone)")
                dateFormatter.timeZone = timezone
                dateString = dateFormatter.string(from: usableDate)


                    self.timeLabel.text = dateString
                                
                }
        }

}
    







