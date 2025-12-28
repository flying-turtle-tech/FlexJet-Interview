//
//  AuthenicationService.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import Foundation

final class AuthenicationService {
    var token: String?
    var loggedIn: Bool {
        get {
            token != nil
        }
        set {
            if newValue == false {
                token = nil
            }
        }
    }
    
    func login(username: String, password: String) async -> Bool {
        guard let token = await APIService.shared.signIn(username: username, password: password) else {
            return false
        }
        self.token = token
        return true
    }
    
    func logout() {
        loggedIn = false
    }
}
