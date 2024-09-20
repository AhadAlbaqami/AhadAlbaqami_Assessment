//
//  CalculatortUnitTest.swift
//  AhadAlbaqami_AssessmentTests
//
//  Created by Ahad Albaqami on 9/18/24.
//

import XCTest
@testable import AhadAlbaqami_Assessment

class CalculatorViewModelTests: XCTestCase {
    var viewModel: CalculatorViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CalculatorViewModel()
    }
    
    func testDivisionByNonZero() {
        let result = viewModel.divide(dividend: 4, divisor: 2)
        XCTAssertEqual(result, 2)
    }
    
    func testDivisionByZero() {
        let result = viewModel.divide(dividend: 5.0, divisor: 0.0) 
        XCTAssertTrue(result.isInfinite, "Result should be infinity when divided by zero")
    }
}
