//
//  DetailsViewController.swift
//  WeatherTest
//
//  Created by Alexey Horokhov on 03.07.2020.
//  Copyright © 2020 Alexey Horokhov. All rights reserved.
//

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: Properties

    private var selectedCityWeather: CityWeather?



    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }



    // MARK: Public

    func update(with CityWeather: CityWeather) {
        self.selectedCityWeather = CityWeather
    }

}
