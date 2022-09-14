//
//  NetworkManagerTests.swift
//  DirectoryTests
//
//  Created by Kesh Gurung on 12/09/2022.
//

import Foundation
import XCTest
@testable import Directory

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.networkManager = NetworkManager(session: MockSession())
    }

    override func tearDownWithError() throws {
        self.networkManager = nil
        try super.tearDownWithError()
    }

    func testGetModelDataSuccess() {
        // Arrange
        var models: [PeoplePage] = []
        let expectation = XCTestExpectation(description: "Successfully Fetched People Data")
        
        // Act
        
        self.networkManager?.getData(url: NetworkParams.people.url) { (result: Result<[PeoplePage], NetworkError>) in
            switch result {
            case .success(let page):
                models = page
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3)
        
        // Assert
        XCTAssertEqual(models.count, 71)
       
    }
    
    func testGetModelDataURLFailure() {
        // Arrange
        var error: NetworkError?
        let expectation = XCTestExpectation(description: "URL Failure")
        
        // Act
        self.networkManager?.getData(url: nil, completion: { (result: Result<[PeoplePage], NetworkError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let err):
                error = err
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3)
        
        // Assert
        XCTAssertEqual(error, NetworkError.urlFailure)
    }
    
    func testGetModelDataFailure() {
        // Arrange
        var error: NetworkError?
        let expectation = XCTestExpectation(description: "Data Failure")
        
        // Act
        self.networkManager?.getData(url: URL(string: "https://DataFailure"), completion: { (result: Result<[PeoplePage], NetworkError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let err):
                error = err
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3)
        
        // Assert
        XCTAssertEqual(error, NetworkError.dataFailure)
    }
    
    func testGetModelGenericFailure() {
        // Arrange
        var error: NetworkError?
        let expectation = XCTestExpectation(description: "Generic Failure")
        
        // Act
        self.networkManager?.getData(url: URL(string: "https://GenericFailure"), completion: { (result: Result<[PeoplePage], NetworkError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let err):
                error = err
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3)
        
        // Assert
        XCTAssertEqual(error, NetworkError.other(NSError(domain: "Test", code: 0, userInfo: nil)))
    }
    
    func testGetModelResponseFailure() {
        // Arrange
        var error: NetworkError?
        let expectation = XCTestExpectation(description: "Status Code Failure")
        
        // Act
        self.networkManager?.getData(url: URL(string: "https://StatusCodeFailure"), completion: { (result: Result<[PeoplePage], NetworkError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let err):
                error = err
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3)
        
        // Assert
        XCTAssertEqual(error, NetworkError.serverResponse(404))
    }
    
//    func testGetModeDecodeFailure() {
//        // Arrange
//        var error: NetworkError?
//        let expectation = XCTestExpectation(description: "Decode Failure")
//        
//        // Act
//        self.networkManager?.getData(url: URL(string: "https://DecodeFailure"), completion: { (result: Result<[PeoplePage], NetworkError>) in
//            switch result {
//            case .success:
//                XCTFail()
//            case .failure(let err):
//                error = err
//                expectation.fulfill()
//            }
//        })
//        wait(for: [expectation], timeout: 3)
//        
//        // Assert
//        XCTAssertEqual(error, NetworkError.decodeError(NSError(domain: "Test", code: 0, userInfo: nil)))
//        
//    }
//    

}
