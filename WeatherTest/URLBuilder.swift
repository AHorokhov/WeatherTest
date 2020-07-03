//
//  URLBuilder.swift
//  WeatherTest
//
//  Created by Alexey Horokhov on 03.07.2020.
//  Copyright © 2020 Alexey Horokhov. All rights reserved.
//

import Foundation

public class URLBuilder {

    public func createURLForFetchingData(with coords: [String: Double]) -> URL? {
        guard let lon = coords["lon"], let lat = coords["lat"] else { return nil }
        let rawUrlString = ApiCommand.GetDetails.rawValue
        let completedURL = rawUrlString.replacingOccurrences(of: "{LON}", with: "\(lon)").replacingOccurrences(of: "{LAT}", with: "\(lat)")
        return URL(string: completedURL)
    }

}
