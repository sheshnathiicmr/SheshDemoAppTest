//
//  RideCellTests.swift
//  RideCellTests
//
//  Created by sheshnath  on 27/05/22.
//

import XCTest
@testable import RideCell

class RideCellTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRepositoryFetch() throws {
        let expectation = XCTestExpectation(description: "expect getting annotation count")
        let mockRepository = MockRepository()
        mockRepository.fetchCabs { result in
            switch result {
            case .success(let cabs):
                XCTAssertTrue(cabs.count == 4, "fetched object count not matched")
                expectation.fulfill()
            case .failure(_):
                XCTAssertTrue(false, "error in fetching cabs info")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testAnnotation() throws {
        let expectation = XCTestExpectation(description: "checking annotation information set correctly")
        let mockRepository = MockRepository()
        let viewModel = MapViewModel(repository: mockRepository)
        mockRepository.fetchCabs { result in
            switch result {
            case .success(let cabs):
                guard let cab = cabs.first else {
                    XCTAssertTrue(true, "failed in getting cabs")
                    return
                }
                let annotation = viewModel.getAnnotation(for: cab)
                XCTAssertTrue(annotation?.title == cab.licensePlateNumber, "annotation title is not correct")
                XCTAssertTrue(annotation?.subtitle == cab.vehicleType, "annotation subtitle is not correct")
                expectation.fulfill()
            case .failure(_):
                XCTAssertTrue(false, "error in fetching cabs info")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
