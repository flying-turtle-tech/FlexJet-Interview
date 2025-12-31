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
    
    init(authService: AuthenicationService) {
        self.authService = authService
    }
    
    func fetchFlights() async {
        guard let token = authService.token else {
            return
        }
        flights = await apiService.loadFlights(token: token) ?? []
    }
}
