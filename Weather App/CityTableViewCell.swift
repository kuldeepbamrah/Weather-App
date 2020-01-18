//
//  CityTableViewCell.swift
//  Weather App
//
//  Created by MacStudent on 2020-01-17.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var feelsLIkeLabel: UILabel!
    @IBOutlet weak var typeOfWeatherImg: UIImageView!
    var typeOfWeather = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setCity(city : String)
    {
        
        cityLabel.text = city
        if let weatherURL = weatherURLMananger.getCityWeatherURL(city: city)
        {
            //create a session
            let session = URLSession.shared
            //create a task
            let task = session.dataTask(with: weatherURL)
            {
                (data,response,error) in
                if data != nil
                {
                    //load the data from json using swift ]json
                    if let weatherData = try? JSON(data: data!)
                    {
                        self.loadIcon(weatherData: weatherData)
                        let temperature = weatherData["main"]["temp"].intValue
                        let feelsLike = weatherData["main"]["feels_like"].stringValue
                        let typeOfWeather = weatherData["weather"][0]["main"].stringValue
                        DispatchQueue.main.async {
                            self.cityTemp.text = "\(temperature) C"
                            self.feelsLIkeLabel.text = "\(feelsLike) C"
                            
                            if typeOfWeather.elementsEqual("Clouds")
                            {
                                 self.typeOfWeatherImg.image = UIImage(named: "coudy.jpg")
                            }
                            else if typeOfWeather.elementsEqual("Clear")
                                                       {
                                                            self.typeOfWeatherImg.image = UIImage(named: "sunny.jpg")
                                                       }
                            else if typeOfWeather.elementsEqual("Rain")
                                                       {
                                                            self.typeOfWeatherImg.image = UIImage(named: "raining.jpg")
                                                       }
                            else if typeOfWeather.elementsEqual("Drizzle")
                                                       {
                                                            self.typeOfWeatherImg.image = UIImage(named: "snow.jpg")
                                                       }
                           
                        }
                        self.typeOfWeather = typeOfWeather
                        print(typeOfWeather)
                        print(weatherData)
                        print("_______________")
                    }
                }
            }
            
            
            task.resume()
            
        }
    }
    
    func loadIcon(weatherData: JSON)
    {
        let weatherArray = weatherData["weather"].arrayValue
        let iconCode = weatherArray[0]["icon"].stringValue
        let iconURL = weatherURLMananger.getWeatherIconURL(iconCode: iconCode)
        let session = URLSession.shared
        
        let task = session.dataTask(with: iconURL!)
        {
            (data,response,error) in
                if data != nil
                {
                    //load the data from json using swift ]json
                    if let iconData = data{
                        DispatchQueue.main.async {
                            self.weatherIconImage.image = UIImage(data: iconData)
                        }
                    }
                    }
                }
           
            task.resume()
        }
    }

