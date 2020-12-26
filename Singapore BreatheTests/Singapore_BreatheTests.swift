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
                //print(psi)
                print(psi[dynamicMember:"north"])
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
    
    func testPM25Download() {
        let expectation = XCTestExpectation(description: "TestPM25Download")
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.pm25.url), completionHandler: { data, response, error in
            guard let receivedData = data else {
                XCTFail("No Data")
                return
            }
            
            do {
                let pm25 = try JSONDecoder().decode(PM25.self, from: receivedData)
                print(pm25)
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
    
    func testCombinedData() {
        
        var bag = Set<AnyCancellable>()
        let expectation = XCTestExpectation(description: "Testing Combined Model")
        
        let _ = NEAInteractor
            .shared
            .combinedPublisher
            .sink { (error) in
                XCTFail("I shouldn't fail here.")
            } receiveValue: { (airQuality) in
                expectation.fulfill()
            }.store(in: &bag)

        NEAInteractor.shared.getLatestMetadataReading()
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
