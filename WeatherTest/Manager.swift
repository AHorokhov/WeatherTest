//
//  Manager.swift
//  WeatherTest
//
//  Created by Alexey Horokhov on 01.07.2020.
//  Copyright © 2020 Alexey Horokhov. All rights reserved.
//

import RxSwift
import RxAlamofire
import Alamofire

protocol Manager {

    func fetchData(for coordinates: [String: Double]) -> Observable<CityWeather?>

}

class ManagerImplementation: Manager {

    static let mainUrlString = "https://sports-app-code-test.herokuapp.com/api/events?date=today"
    static let detailsURLString = "https://sports-app-code-test.herokuapp.com/api/events/"

    func fetchData(for coordinates: [String: Double]) -> Observable<CityWeather?> {
        let url = URLBuilder().createURLForFetchingData(with: coordinates)
        guard let unwrappedUrl = url else { return .just(nil)}
        return Session.default.rx.request(.get, unwrappedUrl)
            .data()
            .map { data -> CityWeather? in
                let cityWeather = try? JSONDecoder().decode(CityWeather.self, from: data)
                return cityWeather
        }
    }
}

