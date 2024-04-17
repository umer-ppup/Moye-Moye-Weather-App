// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let currentWeatherResponse = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: jsonData)

import Foundation

// MARK: - CurrentWeatherResponse
struct CurrentWeatherResponse: Codable {
    let message: String
    let getUpdatedCityWeatherData: GetUpdatedCityWeatherData
    let status: String
}

// MARK: - GetUpdatedCityWeatherData
struct GetUpdatedCityWeatherData: Codable {
    let id: Int
    let lon, lat: Double
    let weatherId: Int
    let weatherMain, weatherDescription, weatherIcon, base: String
    let temperature, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    let seaLevel, grndLevel: JSONNull?
    let visibility: Int
    let windSpeed, rain: Double
    let windDeg: Int
    let windGust, snow: JSONNull?
    let cloudiness, dateTime, sysType, sysId: Int
    let country: String
    let sunrise, sunset, timezone, cityId: Int
    let city: String
    let cityWeatherCode: Int
    let createdAt, updatedAt: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
