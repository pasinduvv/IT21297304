//
//  TrackerApp.swift
//  Tracker
//
//  Created by Vikasitha Herath on 2024-11-26.
//

import SwiftUI

@main
struct TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
