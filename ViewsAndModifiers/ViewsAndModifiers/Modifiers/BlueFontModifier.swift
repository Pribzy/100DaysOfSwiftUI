import SwiftUI

struct BlueFont: ViewModifier {
    var fontType: Font

    func body(content: Content) -> some View {
        content
            .font(fontType)
            .foregroundColor(.blue)
    }
}

extension View {
    func blueFont(with font: Font = .largeTitle) -> some View {
        self.modifier(BlueFont(fontType: font))
    }
}
