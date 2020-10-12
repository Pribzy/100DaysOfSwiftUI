import Foundation

extension UnitLength {
    public var stringValue: String {
        switch self {
        case .millimeters: return "mm"
        case .centimeters: return "cm"
        case .decimeters: return "dm"
        case .meters: return "m"
        case .kilometers: return "km"
        default: return .empty
        }
    }
}
