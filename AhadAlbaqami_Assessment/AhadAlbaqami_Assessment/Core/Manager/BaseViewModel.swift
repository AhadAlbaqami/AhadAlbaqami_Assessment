//
//  BaseViewModel.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Combine
import SwiftUI
import Moya

class BaseViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var showingError = false
    @Published var errorMessage: String = ""
}
