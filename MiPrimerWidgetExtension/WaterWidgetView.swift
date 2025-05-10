import WidgetKit
import SwiftUI

struct WaterEntry: TimelineEntry {
    let date: Date
    var waterCount: Int
}

struct WaterProvider: TimelineProvider {
    func placeholder(in context: Context) -> WaterEntry {
        WaterEntry(date: Date(), waterCount: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (WaterEntry) -> Void) {
        let count = UserDefaults(suiteName: "group.miPrimerWidget")?.integer(forKey: "waterCount") ?? 0
        completion(WaterEntry(date: Date(), waterCount: count))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WaterEntry>) -> Void) {
        let count = UserDefaults(suiteName: "group.miPrimerWidget")?.integer(forKey: "waterCount") ?? 0
        let entry = WaterEntry(date: Date(), waterCount: count)
        completion(Timeline(entries: [entry], policy: .never))
    }
}

struct MiPrimerWidgetExtensionEntryView : View {
    var entry: WaterEntry

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 4) {
                ForEach(0..<7) { index in
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 15, height: 10)
                        .foregroundColor(index < entry.waterCount ? .cyan : .gray.opacity(0.3))
                }
            }


            if entry.waterCount < 7 {
                Button(intent: AddWaterIntent()) {
                    Text("Agregar un vaso de agua")
                        .font(.caption)
                }
                .buttonStyle(.borderedProminent)
            } else {
                VStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .font(.largeTitle)
                    Text("¡Has tomado todos tus vasos diarios!")
                        .font(.caption2)
                    Spacer()
                    Button(intent: ResetWaterIntent()) {
                        Text("Resetear")
                            .font(.caption)
                    }
                    .buttonStyle(.borderedProminent)

                

                    
                }
            }
        }
        .padding()
    }
}

@main
struct MiPrimerWidgetExtension: Widget {
    let kind: String = "Widget Agua"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WaterProvider()) { entry in
            MiPrimerWidgetExtensionEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    Color.clear
                }
        }
        .configurationDisplayName("Agua diaria")
        .description("Registra tu consumo de agua")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}


#Preview(as: .systemMedium) {
    MiPrimerWidgetExtension()
} timeline: {
    WaterEntry(date: .now, waterCount: 0)
    WaterEntry(date: .now, waterCount: 1)
    WaterEntry(date: .now, waterCount: 2)
    WaterEntry(date: .now, waterCount: 3)
}
