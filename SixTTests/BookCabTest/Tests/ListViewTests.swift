//
//  ListViewTests.swift
//  SixTTests
//
//  Created by ityx  on 06/07/22.
//

import XCTest
@testable import SixT

class ListViewTests: XCTestCase {

    var sut:ListViewController!
    var dataSourceViewModel:DataSourceViewModel!
    
    override func setUpWithError() throws {
        self.dataSourceViewModel = DataSourceViewModel(repository: CabRepository(apiHandler: MockAPI(expectation: .success)))
        let listViewModel = ListViewModel(dataSourceViewModel: self.dataSourceViewModel)
        self.sut = ListViewController.initWithStoryboard(viewModel: listViewModel)
        self.sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCellsCount() throws {
        let expectation = XCTestExpectation(description: "expect getting annotation count")
        self.dataSourceViewModel.fetchCabsData { [weak self] newState in
            switch newState {
            case .loaded(let cabs):
                self?.sut.dataAvailable(cabs: cabs)
                XCTAssertTrue(self?.sut.cabsTableView.visibleCells.count == cabs.count, "visible cell either didn't match or datasource having more records than can fit on visisble screens")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testCellShownRightLabel() throws {
        let expectation = XCTestExpectation(description: "expect getting annotation count")
        self.dataSourceViewModel.fetchCabsData { [weak self] newState in
            switch newState {
            case .loaded(let cabs):
                self?.sut.dataAvailable(cabs: cabs)
                let firstCell = self?.sut.cabsTableView.visibleCells.first as! CabInfoTableViewCell
                let firstCab = cabs.first!
                XCTAssertTrue(firstCell.cabNameLabel.text == firstCab.name, "cab name label is not showing right field value")
                XCTAssertTrue(firstCell.licensePlateLabel.text == firstCab.licensePlate, "license plate not showing right field value")
                XCTAssertTrue(firstCell.makeLabel.text == firstCab.make, "make label is not showing right field value")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
