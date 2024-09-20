//
//  LoginView.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 40){
            setupHeaderView()
            
            HStack{
                Text("Login")
                    .foregroundColor(.accentColor)
                    .font(.system(.title, weight: .semibold))
                Spacer()
            }.padding(.horizontal , 16)
            
            setupLoginForm()
            
            Spacer()
        }.background(Color(.systemGroupedBackground).ignoresSafeArea())
            .overlay {
                ZStack {
                    Color.black.ignoresSafeArea().opacity(0.5)
                    ProgressView()
                        .tint(.accentColor)
                }
                .opacity(viewModel.isLoading ? 0.5 : 0)
            }.sheet(isPresented: $viewModel.showingError) {
                AlertSheetView(title: "Error", image: "exclamationmark.circle", subTitle: $viewModel.errorMessage)
            }
    }
    
    @ViewBuilder
    func setupHeaderView() -> some View {
        VStack {
            Image("HeaderImage")
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .edgesIgnoringSafeArea(.top)
        }
    }
    
    @ViewBuilder
    func setupLoginForm() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            CustomeTextFields(textFiled: $viewModel.username, title: "Username", validation: { _ in viewModel.isUsernameValid })
                .disableAutocorrection(true)
            
            CustomeTextFields(textFiled: $viewModel.password, title: "Password", isSecure: true, showIcon: true, validation: { _ in viewModel.isPasswordValid })
            Button(action: {
                viewModel.signIn()
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(viewModel.isFormValid ? Color.accentColor : Color.gray)
                    .cornerRadius(8)
            }.disabled(!viewModel.isFormValid)
        }.padding(.horizontal, 16)
    }
}

#Preview {
    LoginView()
}
