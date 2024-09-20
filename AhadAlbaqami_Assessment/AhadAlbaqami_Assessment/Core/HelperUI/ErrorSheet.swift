//
//  ErrorSheet.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/19/24.
//

import SwiftUI

struct AlertSheetView: View {
    @State var title: String = ""
    @State var image: String = ""
    @Binding var subTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: image)
                    .resizable()
                    .fontWeight(.bold)
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.system(.title, weight: .bold))
            }
            
            Text(subTitle)
                .font(.system(.title2))
        }.foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .presentationDetents([.medium])
    }
}

