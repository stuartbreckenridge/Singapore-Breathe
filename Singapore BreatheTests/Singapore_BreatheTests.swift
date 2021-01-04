//
//  Singapore_BreatheTests.swift
//  Singapore BreatheTests
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import XCTest
import Combine
@testable import Singapore_Breathe

class Singapore_BreatheTests: XCTestCase {

    let api = APIInteractor.shared
    let stack = PersistenceController.shared
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCombinedData() {
        let expectation = XCTestExpectation(description: "Testing Data Download")
        stack.deleteAllReadings()
        XCTAssert(stack.readingCount() == 0)
        api.getLatestMetadataReading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            XCTAssert(self.stack.readingCount() > 0)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }
    
    func testDoubleDisplayString() {
        let double1 = 27.0
        let double2 = 28.5
        XCTAssert(double1.displayString.count == 2)
        XCTAssert(double2.displayString.count == 4)
    }

}
