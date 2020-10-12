public extension String {
    var asDouble: Double { Double(self) ?? .zero }

    static var empty: String { return "" }
}
