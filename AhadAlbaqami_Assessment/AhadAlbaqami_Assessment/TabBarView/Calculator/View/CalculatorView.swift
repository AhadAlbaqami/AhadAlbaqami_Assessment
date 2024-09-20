//
//  CalculatorView.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            setupDivision()
                .padding(.horizontal, 16)
        }.navigationTitle("Calculator")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $viewModel.showingError) {
                AlertSheetView(title: "Error", image: "exclamationmark.circle", subTitle: $viewModel.errorMessage)
            }
    }
    
    @ViewBuilder
    func setupDivision() -> some View {
        VStack(spacing: 24) {
            Image(systemName: "divide.circle.fill")
                .resizable()
                .foregroundColor(.accentColor)
                .frame(width: 60, height: 60)
            
            VStack(spacing: 16) {
                CustomeTextFields(
                    textFiled: $viewModel.dividend, title: "Enter Dividend (X)")
                
                Divider().frame(height: 1)
                
                CustomeTextFields(
                    textFiled: $viewModel.divisor, title: "Enter Divisor (Y)")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(16)
            
            Button(action: {
                viewModel.calculateDivision() }) {
                    Text("Calculate")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(viewModel.isDivionEnabled ? Color.accentColor : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.disabled(!viewModel.isDivionEnabled)
                .padding(.horizontal, 16)
            
            if let result = viewModel.result {
                Text(result, format: .number)
                    .font(.system(.largeTitle, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 70)
                    .background(Color.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.accentColor, lineWidth: 2))
            }
        }.padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.accentColor.opacity(0.7), lineWidth: 2))
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
