//
//  FlightViewModel.swift
//  FlexJetter
//
//  Created by Jonathan on 12/29/25.
//

import Foundation
import SwiftUI

struct FlightViewModel: Identifiable {
    let id: String
    
    let month: String
    let day: String
    let title: String
    let subtitle: String?
    let completed: Bool
    let showTodayBadge: Bool
    let past: Bool
    
    init(flight: Flight) {
        id = flight.id
        month = flight.departure.formatted(.dateTime.month(.abbreviated))
        day = flight.departure.formatted(.dateTime.day(.twoDigits))
        
        let originIndex = flight.origin.firstIndex(of: "(") ?? flight.origin.endIndex
        let origin = flight.origin.prefix(upTo: originIndex).trimmingCharacters(in: .whitespacesAndNewlines)
        let destinationIndex = flight.destination.firstIndex(of: "(") ?? flight.destination.endIndex
        let destination = flight.destination.prefix(upTo: destinationIndex).trimmingCharacters(in: .whitespacesAndNewlines)
        title = [origin, "to", destination].joined(separator: " ")
        
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
        
        past = flight.arrival < Date.now
        subtitle = past ? flight.flightNumber : timeFrame
        showTodayBadge = Calendar.autoupdatingCurrent.isDateInToday(flight.departure) && Date.now < flight.departure
        self.completed = false
    }
}
