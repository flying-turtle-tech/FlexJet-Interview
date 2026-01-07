//
//  FlexJetterApp.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import SwiftUI

@main
struct FlexJetterApp: App {
    @StateObject private var authService: AuthenicationService
    @StateObject private var flightFetcher: FlightFetcher
    
    init() {
        let authService = AuthenicationService()
        let flightFetcher = FlightFetcher(authService: authService)
        _authService = StateObject(wrappedValue: authService)
        _flightFetcher = StateObject(wrappedValue: flightFetcher)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(authService)
        .environmentObject(flightFetcher)
    }
}
