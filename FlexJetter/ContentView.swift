//
//  ContentView.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var authService: AuthenicationService

    private var mainView: some View {
        TabView {
            Tab("Flights", systemImage: "airplane") {
                FlightsMainView()
            }
            Tab("Favorites", systemImage: "heart") {
                UnderConstructionView()
            }
            Tab("Contracts", systemImage: "signature") {
                UnderConstructionView()
            }
            Tab("Profile", systemImage: "person") {
                UnderConstructionView()
            }
        }.symbolVariant(.none)
    }
    
    
    var body: some View {
        Group {
            if authService.loggedIn {
                mainView
            } else {
                LoginView()
            }
        }
        
    }

    
}

#Preview {
    ContentView()
}
