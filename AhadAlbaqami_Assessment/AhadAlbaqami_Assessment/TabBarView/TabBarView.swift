//
//  TabBarView.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var usersListViewModel = UsersListViewModel()

    var body: some View {
        TabView {
            NavigationView {
                UsersListView()
                    .environmentObject(usersListViewModel)
            }.tabItem {
                Label("Users", systemImage: "person.3.fill")
            }

            NavigationView {
                CalculatorView()
            }.tabItem {
                Label("Calculator", systemImage: "divide.square.fill")
            }
        }
    }
}

#Preview {
    TabBarView()
}
