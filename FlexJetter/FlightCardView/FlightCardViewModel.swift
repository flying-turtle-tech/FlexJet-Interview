//
//  FlightViewModel.swift
//  FlexJetter
//
//  Created by Jonathan on 12/29/25.
//

import Foundation
import SwiftUI
import Combine

class FlightCardViewModel: ObservableObject, Identifiable {
    var flight: Flight
    
    var id: String {
        flight.id
    }
    
    var month: String {
        flight.departure.formatted(.dateTime.month(.abbreviated))
    }
    var day: String {
        flight.departure.formatted(.dateTime.day(.twoDigits))
    }
    var title: String {
        let originIndex = flight.origin.firstIndex(of: "(") ?? flight.origin.endIndex
        let origin = flight.origin.prefix(upTo: originIndex).trimmingCharacters(in: .whitespacesAndNewlines)
        let destinationIndex = flight.destination.firstIndex(of: "(") ?? flight.destination.endIndex
        let destination = flight.destination.prefix(upTo: destinationIndex).trimmingCharacters(in: .whitespacesAndNewlines)
        return [origin, "to", destination].joined(separator: " ")
    }
    var subtitle: String? {
        let timeFrame = flight.departure.formatted(
            .dateTime
                .hour(.twoDigits(amPM: .abbreviated))
                .minute(.twoDigits).second(.omitted)
        )
        + " - "
        + flight.arrival.formatted(
            .dateTime
                .hour(.twoDigits(amPM: .abbreviated))
                .minute(.twoDigits).second(.omitted)
        )
        return past ? flight.flightNumber : timeFrame
    }
    
    var showTodayBadge: Bool {
        Calendar.autoupdatingCurrent.isDateInToday(flight.departure) && Date.now < flight.departure
    }
    var past: Bool {
        flight.arrival < Date.now
    }
    
    var completed: Bool {
        flight.completed
    }
    
    init(flight: Flight) {
        self.flight = flight
    }
}
