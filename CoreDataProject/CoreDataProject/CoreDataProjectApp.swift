//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Pribelszki Levente on 2020. 12. 07..
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            WizardView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
