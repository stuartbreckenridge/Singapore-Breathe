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
        
        var comps = URLComponents(url: Endpoints.psi.url, resolvingAgainstBaseURL: false)
        comps?.queryItems = [URLQueryItem(name: "date_time", value: APIInteractor.shared.currentDateTime())]
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: comps!.url!), completionHandler: { data, response, error in
            guard let receivedData = data else {
                XCTFail("No Data")
                return
            }
            do {
                let psi = try JSONDecoder().decode(PSI.self, from: receivedData)
                print(psi)
                expectation.fulfill()
            } catch {
                XCTFail(error.localizedDescription)
                return
            }
            
        })
        task.resume()
        wait(for: [expectation], timeout: 5)
    }
    
    func testPM25Download() {
        let expectation = XCTestExpectation(description: "TestPM25Download")
        var comps = URLComponents(url: Endpoints.pm25.url, resolvingAgainstBaseURL: false)
        comps?.queryItems = [URLQueryItem(name: "date_time", value: APIInteractor.shared.currentDateTime())]
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.pm25.url), completionHandler: { data, response, error in
            guard let receivedData = data else {
                XCTFail("No Data")
                return
            }
            
            do {
                let pm25 = try JSONDecoder().decode(PSI.self, from: receivedData)
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
        
        _ = APIInteractor
            .shared
            .combinedPublisher
            .sink { (error) in
                XCTFail("I shouldn't fail here.")
            } receiveValue: { (airQuality) in
                expectation.fulfill()
            }.store(in: &bag)

        APIInteractor.shared.getLatestMetadataReading()
        wait(for: [expectation], timeout: 5)
    }

}
