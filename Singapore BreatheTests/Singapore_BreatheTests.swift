//
//  Singapore_BreatheTests.swift
//  Singapore BreatheTests
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import XCTest
@testable import Singapore_Breathe

class Singapore_BreatheTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPSIDownload() {
        let expectation = XCTestExpectation(description: "TestPSIDownload")
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.psi.url), completionHandler: { data, response, error in
            guard let receivedData = data else {
                XCTFail("No Data")
                return
            }
            
            do {
                let psi = try JSONDecoder().decode(PSI.self, from: receivedData)
                print(psi)
                expectation.fulfill()
            } catch {
                print(error)
                XCTFail(error.localizedDescription)
                return
            }
            
        })
        task.resume()
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
