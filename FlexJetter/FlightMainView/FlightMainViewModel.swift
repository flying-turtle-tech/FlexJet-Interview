//
//  FlightMainViewModel.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import Foundation
import SwiftUI
import Combine

final class FlightMainViewModel: ObservableObject {
    @Published var flights: [Flight] = []
    var upcomingFlights: [Flight] {
        flights.filter({ $0.arrival >= Date.now})
    }
    var pastFlights: [Flight] {
        flights.filter({ $0.arrival < Date.now})
    }
    
    func loadFlights(using fetcher: FlightFetcher) async {
        flights = await fetcher.fetchFlights() ?? []
    }

}
