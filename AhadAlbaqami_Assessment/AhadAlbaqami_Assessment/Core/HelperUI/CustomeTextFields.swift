//
//  CustomeTextFields.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import SwiftUI

struct CustomeTextFields: View {
    @Binding var textFiled: String
    @State var title: String = ""
    @State var isPasswordVisible = false
    @State var isTextFieldWrong = false
    var isSecure: Bool = false
    var showIcon: Bool = false
    var validation: ((String) -> Bool)? = nil
    var backgroundColor: UIColor = .white
    
    var body: some View {
        HStack {
            if isSecure {
                if isPasswordVisible {
                    TextField(title, text: $textFiled)
                        .padding(.horizontal, 16)
                        .frame(height: 48.39)
                        .onChange(of: textFiled) { _ , newValue in
                            validateField(newValue)
                        }
                } else {
                    SecureField(title, text: $textFiled)
                        .padding(.horizontal, 16)
                        .frame(height: 48.39)
                        .onChange(of: textFiled) { _ , newValue in
                            validateField(newValue)
                        }
                }
                
                if showIcon {
                    Button {
                        withAnimation{
                            isPasswordVisible.toggle()
                        }
                    } label: {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }.padding(.trailing, 10)
                }
            } else {
                TextField(title, text: $textFiled)
                    .padding(.horizontal, 16)
                    .frame(height: 48.39)
                    .onChange(of: textFiled) { _ , newValue in
                        validateField(newValue)
                    }
            }
        }.background(Color(backgroundColor))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isTextFieldWrong ? Color.red : Color.gray.opacity(0.5), lineWidth: 1)
            )
    }
    
    private func validateField(_ value: String) {
        if let validation = validation {
            isTextFieldWrong = !validation(value)
        } else {
            isTextFieldWrong = false
        }
    }
}
