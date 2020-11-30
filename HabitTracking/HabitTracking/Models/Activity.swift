import Foundation

enum ActivityType: String, Codable, CaseIterable {
    case sport
    case learning
    case cook
}

struct Activity: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    let type: ActivityType
}
