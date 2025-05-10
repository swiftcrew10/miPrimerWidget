import AppIntents
import WidgetKit

struct AddWaterIntent: AppIntent {
    static var title: LocalizedStringResource = "Agregar agua"

    func perform() async throws -> some IntentResult {
        let defaults = UserDefaults(suiteName: "group.miPrimerWidget")
        let currentCount = defaults?.integer(forKey: "waterCount") ?? 0

        if currentCount < 7 {
            defaults?.set(currentCount + 1, forKey: "waterCount")
            WidgetCenter.shared.reloadTimelines(ofKind: "Widget Agua")
        }

        return .result()
    }
}

struct ResetWaterIntent: AppIntent {
    static var title: LocalizedStringResource = "Resetear agua"

    func perform() async throws -> some IntentResult {
        let defaults = UserDefaults(suiteName: "group.miPrimerWidget")
        defaults?.set(0, forKey: "waterCount")
        WidgetCenter.shared.reloadTimelines(ofKind: "Widget Agua")
        return .result()
    }
}
