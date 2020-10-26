import Foundation

extension Collection {
    func choose(_ n: Int?) -> ArraySlice<Element> { shuffled().prefix(n ?? count) }
}
