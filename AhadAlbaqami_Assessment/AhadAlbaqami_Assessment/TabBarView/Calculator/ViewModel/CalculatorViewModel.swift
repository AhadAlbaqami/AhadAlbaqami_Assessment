//
//  CalculatorViewModel.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Foundation

class CalculatorViewModel: BaseViewModel {
    @Published var dividend = ""
    @Published var divisor = ""
    @Published var result: Double?
    
    var isDivionEnabled: Bool {
        if !self.dividend.isEmpty && !self.divisor.isEmpty {
            return true
        }
        return false
    }
    
    func calculateDivision() {
        guard let dividend = Double(self.dividend), let divisor = Double(self.divisor) else {
            errorMessage = "Please enter valid numbers."
            showingError = true
            result = nil
            return
        }
        
        guard divisor != 0 else {
            errorMessage = "Division by zero is not allowed."
            showingError = true
            result = nil
            return
        }
        
        result = divide(dividend: dividend, divisor: divisor)
        errorMessage = ""
    }
    
    func divide(dividend: Double, divisor: Double) -> Double {
        return dividend / divisor
    }
}
