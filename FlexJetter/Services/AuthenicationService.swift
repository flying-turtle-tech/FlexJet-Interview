//
//  AuthenicationService.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import Foundation
import SwiftSecurity
import Combine

enum LoginError: Error {
    case loginFailed
}

// Future: Replace ObservableObject with Observable when no longer supporting iOS 16
final class AuthenicationService: ObservableObject {
    private static let credentialName = "flexjetter"
    let keychain = Keychain.default
    @Published var token: String?
    let apiService: APIServiceable
    
    init() {
        token = try? keychain.retrieve(.credential(for: Self.credentialName))
        apiService = APIService.shared
    }
    
    var loggedIn: Bool {
        get {
            token != nil
        }
    }
    
    func login(username: String, password: String) async throws -> Bool {
        do {
            guard let token = try await apiService.signIn(username: username, password: password) else {
                throw LoginError.loginFailed
            }
            self.token = token
            try? keychain.store(token, query: .credential(for: Self.credentialName))
            return true
        } catch {
            throw error
        }
    }
    
    func logout() {
        token = nil
        do {
            try keychain.remove(.credential(for: Self.credentialName))
        } catch {
            print("Error removing keychain token: \(error.localizedDescription)")
        }
    }
}
