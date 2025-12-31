//
//  APIService.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import Foundation

final class APIService {
    private let baseUrl = URL(string: "https://v0-simple-authentication-api.vercel.app/")
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    static let shared = APIService()
        
    func signIn(username: String, password: String) async -> String? {
        guard let baseUrl else { return nil }
        let url = baseUrl.appending(path: "api/signIn")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let payload = LoginRequest(username: username, password: password)
        do {
            request.httpBody = try encoder.encode(payload)
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try decoder.decode(LoginResponse.self, from: data)
            return result.token
        } catch {
            print(error)
            return nil
        }
    }
    
    func loadFlights(token: String) async -> [Flight]? {
        guard let baseUrl else { return nil }
        let url = baseUrl.appending(path: "api/flights")
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try decoder.decode([Flight].self, from: data)
            return result
        } catch {
            print(error)
            return nil
        }
    }
    
}
