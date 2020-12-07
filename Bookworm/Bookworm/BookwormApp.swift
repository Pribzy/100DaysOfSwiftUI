//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Pribelszki Levente on 2020. 12. 07..
//

import SwiftUI

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
