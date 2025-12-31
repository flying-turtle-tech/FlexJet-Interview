//
//  AuthenicationService.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import Foundation
import SwiftSecurity
import Combine

// Future: Replace ObservableObject with Observable when no longer supporting iOS 16
final class AuthenicationService: ObservableObject {
    private static let credentialName = "flexjetter"
    let keychain = Keychain.default
    @Published var token: String?
    
    init() {
        token = try? keychain.retrieve(.credential(for: Self.credentialName))
    }
    
    var loggedIn: Bool {
        get {
            token != nil
        }
    }
    
    func login(username: String, password: String) async -> Bool {
        guard let token = await APIService.shared.signIn(username: username, password: password) else {
            return false
        }
        self.token = token
        try? keychain.store(token, query: .credential(for: Self.credentialName))
        return true
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
