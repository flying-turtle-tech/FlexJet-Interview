//
//  FlexJetterApp.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import SwiftUI
import SwiftData

@main
struct FlexJetterApp: App {
    @StateObject private var authService: AuthenicationService
    @StateObject private var flightFetcher: FlightFetcher
    
    init() {
        let authService = AuthenicationService()
        let flightFetcher = FlightFetcher(authService: authService)
        _authService = StateObject(wrappedValue: authService)
        _flightFetcher = StateObject(wrappedValue: flightFetcher)
        for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
    }
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(authService)
        .environmentObject(flightFetcher)
        .modelContainer(sharedModelContainer)
    }
}
