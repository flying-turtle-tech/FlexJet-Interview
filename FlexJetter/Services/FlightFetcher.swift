//
//  FlightFetcher.swift
//  FlexJetter
//
//  Created by Jonathan on 12/29/25.
//

import Foundation
import Combine

final class FlightFetcher: ObservableObject {
    let apiService = APIService.shared
    let authService: AuthenicationService
    @Published var flights: [Flight] = []
    @Published var errorMessage: String?
    
    init(authService: AuthenicationService) {
        self.authService = authService
    }
    
    func fetchFlights() async {
        guard let token = authService.token else {
            return
        }
        do {
            flights = try await apiService.loadFlights(token: token) ?? []
        } catch {
            errorMessage = "Failed to get flights. Please try again or contact support if the issue persists."
        }
    }
}
