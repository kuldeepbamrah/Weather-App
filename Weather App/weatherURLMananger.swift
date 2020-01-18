//
//  weatherURLMananger.swift
//  Weather App
//
//  Created by MacStudent on 2020-01-17.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation


class weatherURLMananger
{
    static func getCityWeatherURL(city: String) -> URL?
    {
        let city = city.replacingOccurrences(of: " ", with: "%20")
         let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&APPID=0637c9d91efa3d498e8fda2f4540e4f4")!
        return url
    }
    
    static func getWeatherIconURL(iconCode: String) -> URL?
    {
        let urlString = URL(string: "http://api.openweathermap.org/img/w/\(iconCode).png")
        return urlString
    }
    
    static func getgetForecastWeatherURL(city: String) -> URL?
    {
        let city = city.replacingOccurrences(of: " ", with: "%20")
        let urlString = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&APPID=0637c9d91efa3d498e8fda2f4540e4f4")
        return urlString
    }
    
    
    
}
