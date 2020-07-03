//
//  ApiCommand.swift
//  WeatherTest
//
//  Created by Alexey Horokhov on 02.07.2020.
//  Copyright © 2020 Alexey Horokhov. All rights reserved.
//

let apiKey = "975bfa93bb3d4da366de8628d7d30186"

enum ApiCommand: String {

    case GetDetails = "https://api.openweathermap.org/data/2.5/weather?lat={LAT}&lon={LON}&appid=975bfa93bb3d4da366de8628d7d30186"
    case GetWeatherIcon = "http://openweathermap.org/img/wn/@%@4x.png"

}
