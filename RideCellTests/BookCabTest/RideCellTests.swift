//
//  RideCellTests.swift
//  RideCellTests
//
//  Created by ityx  on 27/05/22.
//

import XCTest
@testable import RideCell

class RideCellTests: XCTestCase {

    var mapViewController: MapViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let mockRepository = MockRepository()
        let viewModel = MapViewModel(repository: mockRepository)
        mapViewController = MapViewController.initWithStoryboard(viewModel: viewModel)
        _ = mapViewController.view
        
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
