import Foundation

public enum LenghtUnit: Double, CaseIterable {
    case mm = 1000
    case cm = 100
    case dm = 10
    case m = 1 // This is the standard value
    case km = 0.001

    public var stringValue: String {
        switch self {
        case .mm: return "mm"
        case .cm: return "cm"
        case .dm: return "dm"
        case .m: return "m"
        case .km: return "km"
        }
    }

    public func convertingRatio(to unit: LenghtUnit) -> Double { unit.rawValue / self.rawValue }
}
