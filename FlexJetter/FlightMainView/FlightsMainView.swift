//
//  FlightsMainView.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import SwiftUI

struct FlightsMainView: View {
    @State private var upcomingOrPast = 0
    @State private var addFlight: Bool = false
    @State private var isLoading: Bool = false
    
    @EnvironmentObject private var flightFetcher: FlightFetcher
    
    var upcomingFlights: some View {
        ForEach(flightFetcher.flights.map { FlightViewModel(flight: $0)}.filter { !$0.past }) { flight in
            FlightCardView(viewModel: flight)
                .padding(.horizontal, 17)
                .padding(.vertical, 7.5)
        }
    }
    
    var pastFlights: some View {
        ForEach(flightFetcher.flights.map { FlightViewModel(flight: $0)}.filter { $0.past }) { flight in
            FlightCardView(viewModel: flight)
                .padding(.horizontal, 17)
                .padding(.vertical, 7.5)
        }
    }
    
    @ViewBuilder
    var FlightsView: some View {
        if isLoading {
            ProgressView()
        } else {
            ScrollView {
                LazyVStack {
                    if upcomingOrPast == 0 {
                        upcomingFlights
                    } else {
                        pastFlights
                    }
                }
            }
        }
    }
    
    var body: some View {
        HStack {
            Text("Flights").font(.custom(.semiBold, relativeTo: .title2))
            Spacer()
            Button("", systemImage: "plus.square.fill") {
                addFlight = true
            }.font(.system(size: 24))
            .alert("Not Supported", isPresented: $addFlight) {
                Button("OK", role: .cancel) {
                    addFlight = false
                }
            } message: {
                Text("This action is not yet supported. Please try again later.")
            }
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
        FlightsView.refreshable{
            fetchFlights()
        }.task {
            fetchFlights()
        }
        Spacer()
    }
    
    private func fetchFlights() {
        isLoading = true
        Task {
            await flightFetcher.fetchFlights()
            isLoading = false
        }
    }
}

#Preview {
    FlightsMainView().environmentObject(FlightFetcher(authService: AuthenicationService()))
}
