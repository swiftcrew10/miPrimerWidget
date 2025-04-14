import WidgetKit
import SwiftUI

struct WaterEntry: TimelineEntry {
    let date: Date
    let waterCount: Int
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
        completion(Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60))))
    }
}

struct MiPrimerWidgetExtensionEntryView : View {
    var entry: WaterEntry

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 4) {
                ForEach(0..<3) { index in
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 15, height: 10)
                        .foregroundColor(index < entry.waterCount ? .cyan : .gray.opacity(0.3))
                }
            }


            if entry.waterCount < 3 {
                Button(intent: AddWaterIntent()) {
                    Text("Agregar agua")
                        .font(.caption)
                }
                .buttonStyle(.borderedProminent)
            } else {
                VStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .font(.largeTitle)
                    Text("¡Completado!")
                        .font(.caption2)
                }
            }
        }
        .padding()
    }

    func waterSymbol(for count: Int) -> String {
        switch count {
        case 1: return "wave.1.forward"
        case 2: return "wave.2.forward"
        case 3: return "wave.3.forward"
        default: return "wave.3.forward"
        }
    }

    func opacity(for count: Int) -> Double {
        switch count {
        case 0: return 0.2
        case 1: return 0.4
        case 2: return 0.7
        case 3: return 1.0
        default: return 0.2
        }
    }
}

@main
struct MiPrimerWidgetExtension: Widget {
    let kind: String = "MiPrimerWidgetExtension"

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
