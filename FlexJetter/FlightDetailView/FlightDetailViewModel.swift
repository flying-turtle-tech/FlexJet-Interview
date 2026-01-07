//
//  FlightDetailViewModel.swift
//  FlexJetter
//
//  Created by Jonathan on 12/31/25.
//

import Foundation

struct FlightDetailViewModel {
    struct DetailItem: Identifiable {
        let id = UUID()
        let label: String
        let value: String
    }
    
    let departureDate: String
    let tripNumber: String
    let flightNumber: String?
    let tailNumber: String
    let price: String
    let completeButtonDisabled: Bool
    
    let items: [DetailItem]
    
    init(flight: Flight) {
        self.departureDate = "\(flight.departure.formatted(.dateTime.month(.abbreviated).day())) \(flight.departure.weeksAgo())w ago"
        self.tripNumber = flight.tripNumber
        self.flightNumber = flight.flightNumber
        self.tailNumber = flight.tailNumber
        self.price = "$\(flight.price / 100)"
        items = [
            DetailItem(label: "Departure Date", value: self.departureDate),
            DetailItem(label: "Trip Number", value: self.tripNumber),
            self.flightNumber != nil ? DetailItem(label: "FlightNumber", value: self.flightNumber!) : nil,
            DetailItem(label: "Tail Number", value: self.tailNumber),
            DetailItem(label: "Price", value: self.price),
        ].compactMap({ $0 })
        completeButtonDisabled = flight.departure > Date.now
    }
}

extension Date {
    /// Calculates the number of full weeks between this date and the current date.
    /// Returns 0 if the date is in the future.
    func weeksAgo() -> Int {
        let now = Date()
        // Ensure the current date is "to" and self is "from" to get a positive value for past dates
        guard self <= now else { return 0 }

        let components = Calendar.current.dateComponents([.weekOfYear], from: self, to: now)
        return components.weekOfYear ?? 0
    }
}
