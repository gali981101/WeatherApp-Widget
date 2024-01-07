//
//  Weather_WidgetBundle.swift
//  Weather Widget
//
//  Created by Terry Jason on 2024/1/7.
//

import WidgetKit
import SwiftUI

@main
struct Weather_WidgetBundle: WidgetBundle {
    var body: some Widget {
        Weather_Widget()
        Weather_WidgetLiveActivity()
    }
}
