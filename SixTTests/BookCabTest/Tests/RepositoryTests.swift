//
//  MapViewTests.swift
//  MapViewTests
//
//  Created by sheshnath  on 27/05/22.
//

import XCTest
@testable import SixT

class RepositoryTests: XCTestCase {


    var mockRepository:MockRepository!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.mockRepository = MockRepository()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRepositoryFetch() throws {
        let expectation = XCTestExpectation(description: "expect getting annotation count")
        self.mockRepository.fetchCabs { result in
            switch result {
            case .success(let cabs):
                XCTAssertTrue(cabs.count == 2, "fetched object count not matched")
                expectation.fulfill()
            case .failure(_):
                XCTAssertTrue(false, "error in fetching cabs info")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
}
