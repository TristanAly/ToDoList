//
//  CoreDateToManyApp.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 05/01/2023.
//

import SwiftUI

@main
struct CoreDateToManyApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(.light)
        }.onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}
