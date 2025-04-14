//
//  MiPrimerWidgetExtensionLiveActivity.swift
//  MiPrimerWidgetExtension
//
//  Created by UwU on 14/04/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MiPrimerWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MiPrimerWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MiPrimerWidgetExtensionAttributes.self) { context in
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

extension MiPrimerWidgetExtensionAttributes {
    fileprivate static var preview: MiPrimerWidgetExtensionAttributes {
        MiPrimerWidgetExtensionAttributes(name: "World")
    }
}

extension MiPrimerWidgetExtensionAttributes.ContentState {
    fileprivate static var smiley: MiPrimerWidgetExtensionAttributes.ContentState {
        MiPrimerWidgetExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MiPrimerWidgetExtensionAttributes.ContentState {
         MiPrimerWidgetExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MiPrimerWidgetExtensionAttributes.preview) {
   MiPrimerWidgetExtensionLiveActivity()
} contentStates: {
    MiPrimerWidgetExtensionAttributes.ContentState.smiley
    MiPrimerWidgetExtensionAttributes.ContentState.starEyes
}
