//
//  Weather_Widget.swift
//  Weather Widget
//
//  Created by Terry Jason on 2024/1/7.
//

import WidgetKit
import SwiftUI
import WeatherInfoKit

struct Provider: AppIntentTimelineProvider {
    var defaults = UserDefaults(suiteName: "group.com.gali.weatherapp")!
    
    func placeholder(in context: Context) -> WeatherEntry {
        let weatherData = WeatherData(temperature: 0, weather: "--")
        return WeatherEntry(date: Date(), weatherData: weatherData, configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> WeatherEntry {
        let weatherData = WeatherData(temperature: 28, weather: "Hot")
        return WeatherEntry(date: Date(), weatherData: weatherData, configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<WeatherEntry> {
        var entries: [WeatherEntry] = []

        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        
        if let city = defaults.value(forKey: "city") as? String {
            WeatherService.sharedWeatherService().getCurrentWeather(location: city) { data in
                guard let weatherData = data else { return }
                
                let entry = WeatherEntry(date: currentDate, city: city, weatherData: weatherData, configuration: configuration)
                entries.append(entry)
            }
        }
        
        return Timeline(entries: entries, policy: .after(refreshDate))
    }
}

struct WeatherEntry: TimelineEntry {
    var date: Date
    var city: String = "taipei"
    var weatherData: WeatherData
    
    let configuration: ConfigurationAppIntent
}

struct Weather_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.city.capitalized)
                .font(.system(size: 16, weight: .black, design: .rounded))
                .padding(.bottom, 2)
            Text(entry.weatherData.weather.capitalized)
                .font(.headline)
                .padding(.bottom, 2)
            Text("\(entry.weatherData.temperature)℃")
                .font(.system(size: 20, weight: .black, design: .rounded))
            Text(entry.date, style: .time)
                .font(.footnote)
                .padding(.top, 10)
        }
    }
}

struct Weather_Widget: Widget {
    let kind: String = "Weather_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            Weather_WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Weather Widget")
        .description("This widget is designed to display the current weather information.")
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    Weather_Widget()
} timeline: {
    WeatherEntry(date: .now, weatherData: WeatherData(temperature: 19, weather: "Cloudy"), configuration: .smiley)
    WeatherEntry(date: .now, weatherData: WeatherData(temperature: 19, weather: "Cloudy"), configuration: .starEyes)
}
