//
//  CabInfoBottomSheetTest.swift
//  SixTTests
//
//  Created by sheshnath  on 07/07/22.
//

import XCTest
@testable import SixT

class CabInfoBottomSheetTest: XCTestCase {


    func testExample() throws {
        let dataSourceViewModel = DataSourceViewModel(repository: CabRepository(apiHandler: MockAPI(expectation: .success)))
        let expectation = XCTestExpectation(description: "expect getting annotation count")
        dataSourceViewModel.fetchCabsData { newState in
            switch newState {
            case .loaded(let cabs):
                let firstCab = cabs.first!
                let cabInfoViewController = CabInfoViewController.initWithStoryboard(cab: firstCab)
                cabInfoViewController.loadViewIfNeeded()
                XCTAssertTrue(cabInfoViewController.licensePlateNumberLabel.text == firstCab.licensePlate, "license plate number label don't show right field value")
                XCTAssertTrue(cabInfoViewController.fuelLevelLabel.text == "\(firstCab.fuelLevel)", "fuelLevel label don't show right field value")
                XCTAssertTrue(cabInfoViewController.makeLabel.text == firstCab.make, "make label don't show right field value")
                XCTAssertTrue(cabInfoViewController.name.text == firstCab.name, "right cab name field value is not used")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
        
    }


}
