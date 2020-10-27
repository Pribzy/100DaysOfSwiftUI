import SwiftUI

struct ExpenseModifier: ViewModifier {
    var amount: Int

    private var amountColor: Color {
        switch amount {
        case ..<10: return .green
        case 10..<100: return .gray
        default: return .red
        }
    }

    func body(content: Content) -> some View {
        content.foregroundColor(amountColor)
    }
}

extension View {
    func expensed(with amount: Int) -> some View {
        self.modifier(ExpenseModifier(amount: amount))
    }
}
