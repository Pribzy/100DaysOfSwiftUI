public extension String {
    var asDouble: Double { Double(self) ?? .zero }
}
