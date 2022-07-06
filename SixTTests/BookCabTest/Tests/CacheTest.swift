//
//  CacheTest.swift
//  SixTTests
//
//  Created by sheshnath  on 04/07/22.
//

import XCTest
@testable import SixT

class CacheTest: XCTestCase {

    var cache:ImageCache!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.cache = ImageCache()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCacheSet() throws {
        let testBundle = Bundle(for: type(of: self))
        let image = UIImage(named: "mini_cab", in: testBundle, with: nil)!
        let urlString = "https://cdn.sixt.io/codingtask/images/mini.png"
        self.cache.setImage(with: urlString, image: image)
        XCTAssertTrue(self.cache.getImage(with: urlString) != nil, "setting cache image against key(url) not working")
    }
    
}
