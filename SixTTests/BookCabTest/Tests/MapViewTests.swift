//
//  MapViewTests.swift
//  SixTTests
//
//  Created by sheshnath  on 06/07/22.
//

import XCTest
@testable import SixT

class MapViewTests: XCTestCase {

    var sut:MapViewController!
    var dataSourceViewModel:DataSourceViewModel!
        
    func makeSut(expecation:ExpectationType) {
        self.dataSourceViewModel = DataSourceViewModel(repository: CabRepository(apiHandler: MockAPI(expectation: expecation)))
        let mapViewModel = MapViewModel(dataSourceViewModel: self.dataSourceViewModel)
        self.sut = MapViewController.initWithStoryboard(viewModel: mapViewModel)
        self.sut.loadViewIfNeeded()
    }

    func testAnnotationsCount() throws {
        makeSut(expecation: .success)
        let expectation = XCTestExpectation(description: "expect getting annotation count")
        self.dataSourceViewModel.fetchCabsData { [weak self] newState in
            switch newState {
            case .loaded(let cabs):
                self?.sut.dataAvailable(cabs: cabs)
                XCTAssertTrue(self?.sut.mapView.annotations.count == cabs.count, "map annotations count not match")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testAnnotationShownRightLabel() throws {
        makeSut(expecation: .success)
        let expectation = XCTestExpectation(description: "expect getting annotation count")
        self.dataSourceViewModel.fetchCabsData { [weak self] newState in
            switch newState {
            case .loaded(let cabs):
                self?.sut.dataAvailable(cabs: cabs)
                let firstAnnotation = self?.sut.mapView.annotations.first as! CabPointAnnotation
                let firstCab = firstAnnotation.cab
                XCTAssertTrue(firstAnnotation.title == firstCab.licensePlate, "Annotation title is not showing right field value")
                XCTAssertTrue(firstAnnotation.subtitle == firstCab.name, "Annotation subtitle not showing right field value")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testAnnotationsApiFailed() throws {
        makeSut(expecation: .serverError)
        let expectation = XCTestExpectation(description: "expect getting annotation count")
        self.dataSourceViewModel.fetchCabsData { [weak self] newState in
            switch newState {
            case .failed(_):
                XCTAssertTrue(self?.sut.mapView.annotations.count == 0, " annotations coun't is not zero when api failed")
                expectation.fulfill()
            default:
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
