//
//  Login.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import Foundation

struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct LoginResponse: Decodable {
    let token: String
}
