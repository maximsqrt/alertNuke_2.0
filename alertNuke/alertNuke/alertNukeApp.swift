//
//  alertNukeApp.swift
//  alertNuke
//
//  Created by Maxim Sessler on 09.04.24.
//

import SwiftUI

@main
struct alertNukeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
