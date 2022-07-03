//
//  MapViewTests.swift
//  MapViewTests
//
//  Created by sheshnath  on 27/05/22.
//

import XCTest
@testable import SixT

class MapViewTests: XCTestCase {

    var mapViewController:MapViewController!
    var mapViewModel:MapViewModel!
    var mockRepository:MockRepository!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.mapViewController = MapViewController.initWithStoryboard()
        self.mockRepository = MockRepository()
        self.mapViewModel = MapViewModel(dataSourceViewModel: DataSourceViewModel(repository: mockRepository))
        self.mapViewController.viewModel = self.mapViewModel
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRepositoryFetch() throws {
        let expectation = XCTestExpectation(description: "expect getting annotation count")
        self.mockRepository.fetchCabs { result in
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

    func testAnnotationPointInfo() throws {
        let expectation = XCTestExpectation(description: "checking annotation information set correctly")
        self.mockRepository.fetchCabs { [weak self] result in
            guard let self = self else {
                XCTAssertTrue(true, "failed self is nil")
                return
            }
            switch result {
            case .success(let cabs):
                guard let cab = cabs.first else {
                    XCTAssertTrue(true, "failed in getting cabs")
                    return
                }
                let annotation = self.mapViewModel.getAnnotation(for: cab)
                XCTAssertTrue(annotation?.title == cab.licensePlate, "annotation title is not correct")
                XCTAssertTrue(annotation?.subtitle == cab.name, "annotation subtitle is not correct")
                expectation.fulfill()
            case .failure(_):
                XCTAssertTrue(false, "error in fetching cabs info")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testMapIsPresent() throws {
        let _ = self.mapViewController.view
        XCTAssertTrue(self.mapViewController.mapView != nil, "map is shown")
    }
    
}
