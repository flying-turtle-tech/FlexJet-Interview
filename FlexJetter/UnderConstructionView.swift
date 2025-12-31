//
//  UnderConstructionView.swift
//  FlexJetter
//
//  Created by Jonathan on 12/28/25.
//

import SwiftUI

struct UnderConstructionView: View {
    @EnvironmentObject var authService: AuthenicationService
    
    var body: some View {
        VStack(spacing: 48) {
            Text("Under Construction...")
            
            Button {
                authService.logout()
            } label: {
                Text("Logout").foregroundStyle(Color.white)
            }
            .padding()
            .background(Color.accent)
            .clipShape(RoundedRectangle(cornerRadius: 32))
        }
        
    }
}

#Preview {
    UnderConstructionView().environmentObject(AuthenicationService())
}
