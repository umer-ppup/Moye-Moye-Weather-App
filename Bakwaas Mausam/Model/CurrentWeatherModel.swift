//
//  WeatherModel.swift
//  Bakwaas Mausam
//
//  Created by Atrule User on 29/02/2024.
//

import Foundation

struct CurrentWeatherModel {
    let cityName, message, status, weatherMain, weatherIcon: String
    let temperature, feelsLike, tempMin, tempMax, windSpeed: Double
    let pressure, humidity, visibility, sunrise, sunset, timezone, dateTime, cloudiness, weatherId: Int

    var formattedSunrise: String {
        let date = Date(timeIntervalSince1970: TimeInterval(sunrise))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    var formattedSunset: String {
        let date = Date(timeIntervalSince1970: TimeInterval(sunset))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    var weatherImage: String {
        switch weatherId {
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
