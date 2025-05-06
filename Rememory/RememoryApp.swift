//
//  RememoryApp.swift
//  Rememory
//
//  Created by Mert Akdemir on 06.05.25.
//

import SwiftUI
import SwiftData

let sharedModelContainer: ModelContainer = {
    let schema = Schema([Flashcard.self]) // Hier alle deine Models eintragen
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    return try! ModelContainer(for: schema, configurations: [modelConfiguration])
}()

@main
struct RememoryApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
