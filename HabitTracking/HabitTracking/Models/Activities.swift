import Foundation

class Activities: ObservableObject {
    @Published var items: [Activity] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }

    init() {
        if let items = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }

    func update(activity: Activity) {
        guard let index = getIndex(activity: activity) else { return }

        items[index] = activity
    }

    private func getIndex(activity: Activity) -> Int? {
        return items.firstIndex(where: { $0.id == activity.id })
    }
}
