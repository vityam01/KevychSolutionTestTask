//
//  HourlyForecast.swift
//  KevychTestTaskSwiftUI
//
//  Created by Vitya Mandryk on 06.08.2023.
//

import Foundation


struct HourlyForecast: Codable {
    let cityName: String?
    let countryCode: String?
    let data: [Datum]?
    let lat: Double?
    let lon: Double?
    let stateCode: String?
    let timezone: String?

    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case countryCode = "country_code"
        case data, lat, lon
        case stateCode = "state_code"
        case timezone
    }
}

// MARK: - Datum
struct Datum: Codable {
    let appMaxTemp: Double?
    let appMinTemp: Double?
    let clouds: Int?
    let cloudsHi: Int?
    let cloudsLow: Int?
    let cloudsMid: Int?
    let datetime: String?
    let dewpt: Double?
    let highTemp: Double?
    let lowTemp: Double?
    let maxDhi: JSONNull?
    let maxTemp: Double?
    let minTemp: Double?
    let moonPhase: Double?
    let moonPhaseLunation: Double?
    let moonriseTs: Int?
    let moonsetTs: Int?
    let ozone: Double?
    let pop: Int?
    let precip: Double?
    let pres: Double?
    let rh: Int?
    let slp: Double?
    let snow: Int?
    let snowDepth: Int?
    let sunriseTs: Int?
    let sunsetTs: Int?
    let temp: Double?
    let ts: Int?
    let uv: Double?
    let validDate: String?
    let vis: Double?
    let weather: WeatherHourly?
    let windCdir: String?
    let windCdirFull: String?
    let windDir: Int?
    let windGustSpd: Double?
    let windSpd: Double?
    
    enum CodingKeys: String, CodingKey {
        case appMaxTemp = "app_max_temp"
        case appMinTemp = "app_min_temp"
        case clouds
        case cloudsHi = "clouds_hi"
        case cloudsLow = "clouds_low"
        case cloudsMid = "clouds_mid"
        case datetime, dewpt
        case highTemp = "high_temp"
        case lowTemp = "low_temp"
        case maxDhi = "max_dhi"
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case moonPhase = "moon_phase"
        case moonPhaseLunation = "moon_phase_lunation"
        case moonriseTs = "moonrise_ts"
        case moonsetTs = "moonset_ts"
        case ozone, pop, precip, pres, rh, slp, snow
        case snowDepth = "snow_depth"
        case sunriseTs = "sunrise_ts"
        case sunsetTs = "sunset_ts"
        case temp, ts, uv
        case validDate = "valid_date"
        case vis, weather
        case windCdir = "wind_cdir"
        case windCdirFull = "wind_cdir_full"
        case windDir = "wind_dir"
        case windGustSpd = "wind_gust_spd"
        case windSpd = "wind_spd"
    }
}

// MARK: - Weather
struct WeatherHourly: Codable {
    let icon: String?
    let code: Int?
    let description: String?
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

