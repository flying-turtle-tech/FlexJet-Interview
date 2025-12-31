//
//  Flights.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import Foundation

struct Flight: Codable, Identifiable {
    let id: String
    let tripNumber: String
    let flightNumber: String?
    let tailNumber: String
    /// Las Vegas (LAS)
    let origin: String
    
    /// LAS
    let originIata: String
    
    /// New York (JFK)
    let destination: String
    
    /// JFK
    let destinationIata: String
    ///Timestamps "2025-12-17T09:20:00.000Z"
    let departure: Date
    ///Timestamp "2025-12-17T12:20:00.000Z"
    let arrival: Date
    /// Prive in cents
    let price: Int
    
    static let apiDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = Locale.current.timeZone
            return formatter
        }()
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.tripNumber = try container.decode(String.self, forKey: .tripNumber)
        self.flightNumber = try container.decodeIfPresent(String.self, forKey: .flightNumber)
        self.tailNumber = try container.decode(String.self, forKey: .tailNumber)
        self.origin = try container.decode(String.self, forKey: .origin)
        self.originIata = try container.decode(String.self, forKey: .originIata)
        self.destination = try container.decode(String.self, forKey: .destination)
        self.destinationIata = try container.decode(String.self, forKey: .destinationIata)
        let departureString = try container.decode(String.self, forKey: .departure)
        if let departureDate = Self.apiDateFormatter.date(from: departureString) {
            departure = departureDate
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [Flight.CodingKeys.departure], debugDescription: "Failed to format departure date"))
        }
        let arrivalString = try container.decode(String.self, forKey: .arrival)
        if let arrivalDate = Self.apiDateFormatter.date(from: arrivalString) {
            arrival = arrivalDate
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [Flight.CodingKeys.arrival], debugDescription: "Failed to format arrival date"))
        }
        self.price = try container.decode(Int.self, forKey: .price)
    }
    
    init(id: String, tripNumber: String, flightNumber: String?, tailNumber: String, origin: String, originIata: String, destination: String, destinationIata: String, departure: Date, arrival: Date, price: Int) {
        self.id = id
        self.tripNumber = tripNumber
        self.flightNumber = flightNumber
        self.tailNumber = tailNumber
        self.origin = origin
        self.originIata = originIata
        self.destination = destination
        self.destinationIata = destinationIata
        self.departure = departure
        self.arrival = arrival
        self.price = price
    }
}

struct FlightResponse: Codable {
    let response: [Flight]
}
