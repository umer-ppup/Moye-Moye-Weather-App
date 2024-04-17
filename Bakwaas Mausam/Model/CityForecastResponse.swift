// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cityForecastResponse = try? JSONDecoder().decode(CityForecastResponse.self, from: jsonData)

import Foundation

// MARK: - CityForecastResponse
struct CityForecastResponse: Codable {
    let updatedForecastData: UpdatedForecastData
    let updatedDailyForecast: [UpdatedDailyForecast]
}

// MARK: - UpdatedDailyForecast
struct UpdatedDailyForecast: Codable {
    let id, dt: Int
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double
    let weatherId: Int
    let weatherMain: String
    let weatherDescription: String
    let weatherIcon: String
    let cloudiness: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let visibility: Int
    let pop: Double
    let sysPod: String
    let dtTxt: String
    let cityId: Int
    let createdAt, updatedAt: String
}


// MARK: - UpdatedForecastData
struct UpdatedForecastData: Codable {
    let id: Int
    let name: String
    let lat, long: Double
    let country: String
    let population, timezone, sunrise, sunset: Int
    let createdAt, updatedAt: String
    let weatherDataList: [UpdatedDailyForecast]
}
