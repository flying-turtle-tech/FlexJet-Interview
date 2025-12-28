//
//  Flights.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import Foundation

struct Flight: Codable {
    let id: String
    let tripNumber: String
    let flightNumber: String
    let tailNumber: String
    let origin: String
    let originIata: String
    let destination: String
    let destinationIata: String
    //Timestamps "2025-12-17T09:20:00.000Z"
    let departure: Date
    //Timestamp "2025-12-17T12:20:00.000Z"
    let arrival: Date
    // Prive in cents
    let price: Int
}
