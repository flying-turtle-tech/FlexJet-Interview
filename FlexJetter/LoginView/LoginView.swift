//
//  LoginView.swift
//  FlexJetter
//
//  Created by Jonathan on 12/29/25.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loading: Bool = false
    @State private var errorMessage: String?

    @EnvironmentObject var authService: AuthenicationService
    
    var body: some View {
        VStack(spacing: 16) {
            Text("FlexJetter").font(Font.largeTitle)
                .bold()
            Text("Manage your flight schedule")
                .foregroundStyle(.accent)
        }.padding(32)
        Form {
            VStack(spacing: 32) {
                VStack(alignment: .leading) {
                    Text("Username")
                    TextField("Username field", text: $username, prompt: Text("Required"))
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading) {
                    Text("Password")
                    SecureField("Password Field", text: $password, prompt: Text("Required"))
                        .textContentType(.password)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                }
                Button(action: handleLogin) {
                    if loading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                    } else {
                        Text("Login")
                              .bold()
                              .padding(.horizontal, 32)
                              .padding()
                              .background(.accent)
                              .foregroundStyle(.white)
                              .clipShape(.buttonBorder)
                    }
                }
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(Color.red)
                        .padding()
                }
            }
        }
    }
    
    private func handleLogin() {
        loading = true
        Task {
            do {
                let _ = try await authService.login(username: username, password: password)
                loading = false
            } catch {
                print(error)
                errorMessage = "Failed to login. Please try again."
            }
        }
    }
}



#Preview {
    LoginView()
        .environmentObject(AuthenicationService())
}
