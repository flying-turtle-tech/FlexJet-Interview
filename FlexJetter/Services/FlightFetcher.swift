//
//  FlightFetcher.swift
//  FlexJetter
//
//  Created by Jonathan on 12/29/25.
//

import Foundation
import Combine

final class FlightFetcher: ObservableObject {
    let apiService: APIServiceable = APIService.shared
    let authService: AuthenicationService
    @Published var flights: [Flight] = []
    @Published var errorMessage: String?
    
    init(authService: AuthenicationService) {
        self.authService = authService
    }
    
    func fetchFlights() async -> [Flight]? {
        guard let token = authService.token else {
            return nil
        }
        do {
            flights = try await apiService.loadFlights(token: token) ?? []
            return flights
        } catch {
            errorMessage = "Failed to get flights. Please try again or contact support if the issue persists."
            return nil
        }
    }
}
