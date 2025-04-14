import AppIntents

struct AddWaterIntent: AppIntent {
    static var title: LocalizedStringResource = "Agregar agua"

    func perform() async throws -> some IntentResult {
        let defaults = UserDefaults(suiteName: "group.miPrimerWidget")
        let currentCount = defaults?.integer(forKey: "waterCount") ?? 0
        
        if currentCount < 3 {
            defaults?.set(currentCount + 1, forKey: "waterCount")
        }

        return .result()
    }
}
