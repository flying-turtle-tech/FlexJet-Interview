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
    @StateObject private var viewModel: FlightMainViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: FlightMainViewModel())
    }
    
    private var titleView: some View {
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
        }
        .padding(.horizontal, 30)
    }
    
    private var upcomingFlights: some View {
        ForEach(viewModel.flights.filter({ $0.departure > Date.now })) { flight in
            NavigationLink(value: flight) {
                FlightCardView(flight: flight, completed: Binding(get: { return false}, set: { _ in }))
                    .padding(.horizontal, 17)
                    .padding(.vertical, 7.5)
            }
        }
    }
    
    private var pastFlights: some View {
        ForEach(viewModel.flights.filter({ $0.departure <= Date.now })) { flight in
            NavigationLink(value: flight) {
                let completed = $viewModel.flights.first(where: { $0.wrappedValue == flight})!.completed
                FlightCardView(flight: flight, completed: completed)
                    .padding(.horizontal, 17)
                    .padding(.vertical, 7.5)
            }
        }
    }
    
    @ViewBuilder
    private var FlightsView: some View {
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
        NavigationStack {
            titleView
            VStack {
                Picker("Past or Upcoming", selection: $upcomingOrPast) {
                    Text("Upcoming").tag(0)
                    Text("Past").tag(1)
                }
                .pickerStyle(.segmented)
            }
            .padding(16)
            FlightsView.refreshable{
                fetchFlights()
            }.task {
                if flightFetcher.flights.isEmpty {
                    fetchFlights()
                }
            }
            .navigationDestination(for: Flight.self) { flight in
                if let index = viewModel.flights.firstIndex(of: flight) {
                        FlightDetailView(flight: $viewModel.flights[index])
                    }
            }
            Spacer()
                
        }
    }
    
    private func fetchFlights() {
        isLoading = true
        Task {
            await viewModel.loadFlights(using: flightFetcher)
            isLoading = false
        }
    }
}

#Preview {
    FlightsMainView().environmentObject(FlightFetcher(authService: AuthenicationService()))
}
