//
//  CityTableViewCell.swift
//  WeatherTest
//
//  Created by Alexey Horokhov on 03.07.2020.
//  Copyright © 2020 Alexey Horokhov. All rights reserved.
//

import UIKit
import AlamofireImage

final class CityTableViewCell: UITableViewCell {

    // MARK: Properties


    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!



    // MARK: Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()

        mainImageView.image = nil
        cityNameLabel.text = nil
        temperatureLabel.text = nil
    }

    public func update(with cityWeather: CityWeather) {
        cityNameLabel.text = cityWeather.cityName
        temperatureLabel.text = "\(cityWeather.temp)"
    }

}
