import WidgetKit
import SwiftUI

@main
struct WaterWidget: Widget {
    let kind: String = "WaterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WaterProvider()) { entry in
            WaterWidgetView(entry: entry)
        }
        .configurationDisplayName("Agua diaria")
        .description("Registra tu consumo de agua.")
        .supportedFamilies([.systemSmall])
    }
}
