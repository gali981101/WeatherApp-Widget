//
//  Weather_WidgetLiveActivity.swift
//  Weather Widget
//
//  Created by Terry Jason on 2024/1/7.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Weather_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Weather_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Weather_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Weather_WidgetAttributes {
    fileprivate static var preview: Weather_WidgetAttributes {
        Weather_WidgetAttributes(name: "World")
    }
}

extension Weather_WidgetAttributes.ContentState {
    fileprivate static var smiley: Weather_WidgetAttributes.ContentState {
        Weather_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Weather_WidgetAttributes.ContentState {
         Weather_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Weather_WidgetAttributes.preview) {
   Weather_WidgetLiveActivity()
} contentStates: {
    Weather_WidgetAttributes.ContentState.smiley
    Weather_WidgetAttributes.ContentState.starEyes
}
