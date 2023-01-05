//
//  CoreDateToManyApp.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 05/01/2023.
//

import SwiftUI

@main
struct CoreDateToManyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
