import SwiftUI

@main
struct CupcakeCornerApp: App {
    var body: some Scene {
        WindowGroup {
            OrderView(observableOrder: ObservableOrder(order: OrderStruct()))
        }
    }
}
