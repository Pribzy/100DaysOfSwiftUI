import SwiftUI

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BookwormView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
