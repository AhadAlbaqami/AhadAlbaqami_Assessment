//
//  UsersListView.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import SwiftUI

struct UsersListView: View {
    @EnvironmentObject var viewModel: UsersListViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(viewModel.usersListArray, id: \.self) { user in
                    setupUserInfo(user: user)
                        .padding(.horizontal)
                }
            }.padding(.top)
        }.navigationTitle("Users List")
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .overlay {
                ZStack {
                    ProgressView()
                        .tint(.accentColor)
                }.opacity(viewModel.isLoading ? 1 : 0)
            }.sheet(isPresented: $viewModel.showingError) {
                AlertSheetView(title: "Error", image: "exclamationmark.circle", subTitle: $viewModel.errorMessage)
            }.onAppear {
                viewModel.fetchUsersList()
            }
    }
    
    @ViewBuilder
    func setupUserInfo(user: UsersList) -> some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: user.user.profileImage.medium)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }.frame(width: 60, height: 60)
                .cornerRadius(8)
            
            Text(user.user.username)
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
        }.padding([.horizontal , .vertical], 16)
            .background(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .cornerRadius(8)
    }
}

#Preview {
    UsersListView()
}
