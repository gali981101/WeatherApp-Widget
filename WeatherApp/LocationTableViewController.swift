//
//  LocationTableViewController.swift
//  WeatherApp
//
//  Created by Terry Jason on 2024/1/7.
//

import UIKit
import WidgetKit

class LocationTableViewController: UITableViewController {
    
    let locations: [String] = ["Taipei, Taiwan", "Tokyo, Japan", "Sydney, Australia", "Seattle, U.S.", "New York, U.S.", "Hong Kong, Hong Kong", "Paris, France", "London, U.K.", "Vancouver, Canada"]
    
    private(set) var selectedCity = ""
    private(set) var selectedCountry = ""
    
    var selectedLocation: String = "" {
        didSet {
            let location = selectedLocation.split { $0 == "," }.map { String($0) }
            selectedCity = location[0]
            selectedCountry = location[1].trimmingCharacters(in: .whitespaces)
        }
    }
    
    var defaults = UserDefaults(suiteName: "group.com.gali.weatherapp")!
    
}

// MARK: - Life Cycle

extension LocationTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Table view data source

extension LocationTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = locations[indexPath.row]
        cell.accessoryType = (locations[indexPath.row] == selectedLocation) ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        if let location = cell?.textLabel?.text {
            selectedLocation = location
            defaults.setValue(selectedCity, forKey: "city")
        }
        tableView.reloadData()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}
