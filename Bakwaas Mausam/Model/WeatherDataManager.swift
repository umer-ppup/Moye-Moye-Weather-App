//
//  DataManager.swift
//  Bakwaas Mausam
//
//  Created by Atrule User on 29/02/2024.
//

import Foundation

protocol DataManagerDelegate {
    func didUpdateCurrentWeather(_ weatherManager: WeatherDataManager, weather: CurrentWeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherDataManager {
    
    var delegate: DataManagerDelegate?
    
    let baseUrl = "https://weather.atrule.com/"
    let apiAuthorizationToken = "Bearer $2a$12$oPbE2aucU1dUV8s0I21ie.3o8AIu1m9FtC1RYgE6VJX8tMtoh0CfS";

    func fetchCurrentWeather(cityName: String) {
        let cityWeatherDataUrl = "\(baseUrl)/api/weather/\(cityName)";
        performRequest(with: cityWeatherDataUrl, isForecast: false)
    }
    
    func fetchWeatherForecast(cityName: String) {
        let cityWeatherForecastUrl = "\(baseUrl)/api/forecast/\(cityName)";
        performRequest(with: cityWeatherForecastUrl, isForecast: true)
    }
    
    func performRequest(with urlString: String, isForecast: Bool) {
        let apiAuthorizationToken = "Bearer $2a$12$oPbE2aucU1dUV8s0I21ie.3o8AIu1m9FtC1RYgE6VJX8tMtoh0CfS";
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(apiAuthorizationToken, forHTTPHeaderField: "Authorization")

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                 if let safeData = data{
                    if isForecast {
                        if let weather = self.parseForecastJSON(safeData) {
                            print("forecast weather: \(weather)")
                        }
                    }
                    else {
                        if let weather = self.parseCurrentWeatherJSON(safeData) {
                            self.delegate?.didUpdateCurrentWeather(self, weather: weather)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseForecastJSON(_ forecastWeatherData: Data) -> CityForecastResponse? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CityForecastResponse.self, from: forecastWeatherData)
            return decodedData
        } catch {
            print("parseForecastJSON error: \(error)")
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseCurrentWeatherJSON(_ currentWeatherData: Data) -> CurrentWeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrentWeatherResponse.self, from: currentWeatherData)
            let cityData = decodedData.getUpdatedCityWeatherData
            let weather = CurrentWeatherModel(cityName: cityData.city,
                                              message: decodedData.message, status: decodedData.status,
                                              weatherMain: cityData.weatherMain,
                                              weatherIcon: cityData.weatherIcon,
                                              temperature: cityData.temperature,
                                              feelsLike: cityData.feelsLike,
                                              tempMin: cityData.tempMin,
                                              tempMax: cityData.tempMax,
                                              windSpeed: cityData.windSpeed,
                                              pressure: cityData.pressure,
                                              humidity: cityData.humidity,
                                              visibility: cityData.visibility,
                                              sunrise: cityData.sunrise,
                                              sunset: cityData.sunset,
                                              timezone: cityData.timezone,
                                              dateTime: cityData.dateTime,
                                              cloudiness: cityData.cloudiness,
                                              weatherId: cityData.weatherId
            )
            print("weather \(weather)")
            return weather
        } catch {
            print("parseCurrentWeatherJSON: \(error)")
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
 }
