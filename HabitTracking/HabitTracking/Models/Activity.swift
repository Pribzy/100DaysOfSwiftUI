import Foundation
import SwiftUI

enum ActivityType: String, Codable, CaseIterable {
    case sport
    case learning
    case cook

    var iconName: String {
        switch self {
        case .sport: return "sportscourt.fill"
        case .learning:  return "book.fill"
        case .cook:  return "text.book.closed.fill"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .sport: return Color.green
        case .learning:  return Color.blue
        case .cook:  return Color.orange
        }
    }
}

struct Activity: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    let type: ActivityType
    var completionTimes: Int = 0
}
