import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CandyView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
