//
//  ViewController.swift
//  Bakwaas Mausam
//
//  Created by Atrule User on 28/02/2024.
//

import UIKit
 
class ViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherQuoteLabel: UILabel!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    var dataManager = WeatherDataManager()
    let cityName = "Karachi"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        self.dataManager.fetchCurrentWeather(cityName: cityName)
        getCurrentDate()
    }
    
    func getCurrentDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMMM dd"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        dateLabel.text = formattedDate
    }
}

// MARK: - DataManagerDelegate
extension ViewController: DataManagerDelegate {
    func didUpdateCurrentWeather(_ weatherManager: WeatherDataManager, weather: CurrentWeatherModel) {
        DispatchQueue.main.async {
            self.locationLabel.text = weather.cityName
            self.temperatureLabel.text = "\(Int(weather.temperature.rounded()))"
            self.weatherConditionLabel.text = weather.weatherMain
            self.weatherQuoteLabel.text = weather.status
            self.minMaxTempLabel.text =  "\(Int(weather.tempMax.rounded())) / \(Int(weather.tempMin.rounded()))  Feels Like: \(Int(weather.feelsLike.rounded()))"
            self.humidityLabel.text = "\(weather.humidity)%"
            self.cloudinessLabel.text = "\(weather.cloudiness)%"
            self.windLabel.text = "\(weather.windSpeed) Km/H"
            self.visibilityLabel.text = "\(weather.visibility / 1000) Km"
            self.sunriseLabel.text = weather.formattedSunrise
            self.sunsetLabel.text = weather.formattedSunset
            self.weatherImage.image = UIImage(systemName: weather.weatherImage)

//            URLSession.shared.dataTask(with: URL(string: "http://openweathermap.org/img/w/\(weather.weatherIcon)@2x.png")!) { iconData, _ , _ in
//                if let data = iconData {
//                    DispatchQueue.main.async {
//                        self.weatherImage.image = UIImage(data: data)
//                    }
//                }
//            }.resume()
            
//            let urlStr = NSURL(string:"http://openweathermap.org/img/w/\(weather.weatherIcon).png")
//            let urlData = NSData(contentsOf: urlStr! as URL)
//            if urlData != nil {
//                DispatchQueue.main.async {
//                    self.weatherImage.image = UIImage(data: urlData! as Data)
//                }
//            }
        }
    }
    
    func didFailWithError(error: Error) {
        print("didFailWithError \(error)")
    }
}
