//
//  AhadAlbaqami_AssessmentApp.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import SwiftUI

@main
struct AhadAlbaqami_AssessmentApp: App {
    @StateObject var loginViewModel = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            if loginViewModel.isAuthenticated {
                TabBarView()
            } else {
                LoginView()
                    .environmentObject(loginViewModel)
            }
        }
    }
}
