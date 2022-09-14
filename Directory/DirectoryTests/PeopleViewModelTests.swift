//
//  PeopleViewModelTests.swift
//  DirectoryTests
//
//  Created by Kesh Gurung on 12/09/2022.
//


import XCTest
@testable import Directory

class PeopleViewModelTests: XCTestCase {
    var viewModel: PeopleViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.viewModel = PeopleViewModel(networkManager: MockService())
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        try super.tearDownWithError()
    }
    
    func testRequestModelDataSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Successfully retrieving Models")
        
        // Act
        self.viewModel?.bind {
            expectation.fulfill()
        }
        self.viewModel?.getPeople()
        wait(for: [expectation], timeout: 3)
        
        // Assert
        XCTAssertEqual(self.viewModel?.count, 71)
        XCTAssertEqual(self.viewModel?.lastName(for: 0),"Brekke")
    }
}
