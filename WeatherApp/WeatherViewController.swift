//
//  ViewController.swift
//  WeatherApp
//
//  Created by Terry Jason on 2024/1/7.
//

import UIKit
import WeatherInfoKit

class WeatherViewController: UIViewController {
    
    var city: String = "Taipei"
    var country: String = "Taiwan"
    
    // MARK: - @IBOulet
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
}

// MARK: - Life Cycle

extension WeatherViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherLabel.text = ""
        temperatureLabel.text = ""
        
        displayCurrentWeather()
    }
    
}

// MARK: - Get Data

extension WeatherViewController {
    
    private func displayCurrentWeather() {
        cityLabel.text = city
        countryLabel.text = country
        
        WeatherService.sharedWeatherService().getCurrentWeather(location: city) { data in
            OperationQueue.main.addOperation {
                guard let weatherData = data else { fatalError() }
                self.weatherLabel.text = weatherData.weather.capitalized
                self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
            }
        }
    }
    
}

// MARK: - Action methods

extension WeatherViewController {
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }
    
    @IBAction func updateWeatherInfo(segue: UIStoryboardSegue) {
        let sourceVC = segue.source as! LocationTableViewController
        
        city = sourceVC.selectedCity
        country = sourceVC.selectedCountry
        
        displayCurrentWeather()
    }
    
}

// MARK: - Navigation

extension WeatherViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocations" {
            let destinationVC = segue.destination as! UINavigationController
            let locationVC = destinationVC.viewControllers[0] as! LocationTableViewController
            locationVC.selectedLocation = "\(city), \(country)"
        }
    }
    
}
