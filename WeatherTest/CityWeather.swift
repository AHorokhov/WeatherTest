//
//  CityWeather.swift
//  WeatherTest
//
//  Created by Alexey Horokhov on 01.07.2020.
//  Copyright © 2020 Alexey Horokhov. All rights reserved.
//

import Foundation

struct CityWeather: Decodable {

    let cityName: String
    let timeZone: TimeInterval
    let currentDate: TimeInterval

    // City coordinates

    var cityCoords: [String: Double]

    // Weather

    let weatherState: String?
    let weatherIconId: String?

    // Wind

    let windSpeed: Double?
    let windGust: Double?

    // Main params

    let temp: Double?
    let realFeelTemp: Double?
    let dailyMinTemp: Double?
    let dailyMaxTemp: Double?
    let pressure: Double?
    let humidity: Double?
    let seaLevelPressure: Double?
    let groundLevelPressure: Double?

    // Clouds

    let amountOfCloudsInPercent: Double?

    // Global stats

    let countryCode: String?
    let sunrise: TimeInterval?
    let sunset: TimeInterval?

    enum CodingKeys: String, CodingKey {
        case name
        case currentDate = "dt"
        case timeZone = "timezone"
        case coordinates = "coord"
        case weather
        case mainStats = "main"
        case wind
        case clouds
        case globalStats = "sys"
        case seaLevelPressure
        case groundLevelPressure
    }

    enum CoordinatesCodingKeys: String, CodingKey {
        case lon
        case lat
    }

    enum WeatherCodingKeys: String, CodingKey {
        case state = "main"
        case icon
    }

    enum MainStatsCodingKeys: String, CodingKey {
        case temp
        case realFeel = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case humidity
        case seaLevelPressure = "sea_level"
        case groundLevelPressure = "grnd_level"
    }

    enum WindCodingKeys: String, CodingKey {
        case speed
        case gust
    }
    enum CloudsCodingKeys: String, CodingKey {
        case amountInPercent = "all"
    }

    enum GlobalStatsCodingKeys: String, CodingKey {
        case countryCode = "country"
        case sunset
        case sunrise
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try container.decode(String.self, forKey: .name)
        currentDate = try container.decode(TimeInterval.self, forKey: .currentDate)
        timeZone = try container.decode(TimeInterval.self, forKey: .timeZone)

        // Nested coordinates

         let coordinatesContainer = try container.nestedContainer(keyedBy: CoordinatesCodingKeys.self, forKey: .coordinates)
        cityCoords = ["lon": try coordinatesContainer.decode(Double.self, forKey: .lon)]
        cityCoords["lat"] = try coordinatesContainer.decode(Double.self, forKey: .lat)

        // Nested weather

        let weaherContainer = try? container.nestedContainer(keyedBy: WeatherCodingKeys.self, forKey: .weather)
        weatherState = try? weaherContainer?.decode(String.self, forKey: .state)
        weatherIconId = try? weaherContainer?.decode(String.self, forKey: .icon)

        // Nested main stats

        let mainStatsContainer = try? container.nestedContainer(keyedBy: MainStatsCodingKeys.self, forKey: .mainStats)
        temp = try? mainStatsContainer?.decode(Double.self, forKey: .temp)
        realFeelTemp = try? mainStatsContainer?.decode(Double.self, forKey: .realFeel)
        dailyMinTemp = try? mainStatsContainer?.decode(Double.self, forKey: .minTemp)
        dailyMaxTemp = try? mainStatsContainer?.decode(Double.self, forKey: .maxTemp)
        pressure = try? mainStatsContainer?.decode(Double.self, forKey: .pressure)
        humidity = try? mainStatsContainer?.decode(Double.self, forKey: .humidity)
        seaLevelPressure = try? mainStatsContainer?.decode(Double.self, forKey: .seaLevelPressure)
        groundLevelPressure = try? mainStatsContainer?.decode(Double.self, forKey: .groundLevelPressure)

        // Nested wind

        let windContainer = try? container.nestedContainer(keyedBy: WindCodingKeys.self, forKey: .wind)
        windSpeed = try? windContainer?.decode(Double.self, forKey: .speed)
        windGust = try? windContainer?.decode(Double.self, forKey: .gust)

        // Nested clouds

        let cloudsContainer = try? container.nestedContainer(keyedBy: CloudsCodingKeys.self, forKey: .clouds)
        amountOfCloudsInPercent = try? cloudsContainer?.decode(Double.self, forKey: .amountInPercent)

        // Nested global stats

        let globalStatsContainer = try? container.nestedContainer(keyedBy: GlobalStatsCodingKeys.self, forKey: .globalStats)
        countryCode = try? globalStatsContainer?.decode(String.self, forKey: .countryCode)
        sunset = try? globalStatsContainer?.decode(TimeInterval.self, forKey: .sunset)
        sunrise = try? globalStatsContainer?.decode(TimeInterval.self, forKey: .sunrise)
    }
}
