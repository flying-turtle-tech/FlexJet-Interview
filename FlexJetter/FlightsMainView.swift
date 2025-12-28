//
//  FlightsMainView.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import SwiftUI

struct FlightsMainView: View {
    @State private var upcomingOrPast = 0
    
    
    var body: some View {
        HStack {
            Text("Flights").font(.largeTitle).bold()
            Spacer()
            Image(systemName: "plus.square.fill").tint(.accentColor)
        }.padding(.horizontal, 30)
        VStack {
            Picker("Past or Upcoming", selection: $upcomingOrPast) {
                Text("Upcoming").tag(0)
                Text("Past").tag(1)
            }
            .pickerStyle(.segmented)
        }
        .padding(16)
        .navigationTitle("Flying")
        Group {
            if upcomingOrPast == 0 {
                Text("Upcoming")
            } else {
                Text("Past")
            }
        }
        Spacer()

    }
}

#Preview {
    FlightsMainView()
}
