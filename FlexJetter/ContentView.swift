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
    @Query private var items: [Item]

    var body: some View {
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

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
