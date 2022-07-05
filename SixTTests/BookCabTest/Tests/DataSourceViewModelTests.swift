//
//  DataSourceViewModelTests.swift
//  MapViewTests
//
//  Created by sheshnath  on 27/05/22.
//

import XCTest
@testable import SixT

class DataSourceViewModelTests: XCTestCase {


    var viewModel:DataSourceViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.viewModel = DataSourceViewModel(repository: CabRepository(apiHandler: MockAPI()))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetch() throws {
        let expectation = XCTestExpectation(description: "expect getting annotation count")
        self.viewModel.fetchCabsData { newState in
            switch newState {
            case .loaded(let cabs):
                XCTAssertTrue(cabs.count == 2, "fetched object count not matched")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
}
