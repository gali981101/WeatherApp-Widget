//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Terry Jason on 2024/1/7.
//

import Foundation

public struct WeatherData {
    
    public var temperature: Int = 0
    public var weather: String = ""
    
    public init() {}
    
    public init(temperature: Int, weather: String) {
        self.temperature = temperature
        self.weather = weather
    }
    
}
