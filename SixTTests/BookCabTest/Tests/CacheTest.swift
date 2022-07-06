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
        self.cache = ImageCache()
    }

    func testCacheSet() throws {
        let testBundle = Bundle(for: type(of: self))
        let image = UIImage(named: "mini_cab", in: testBundle, with: nil)!
        let urlString = "https://cdn.sixt.io/codingtask/images/mini.png"
        self.cache.setImage(with: urlString, image: image)
        XCTAssertTrue(self.cache.getImage(with: urlString) != nil, "setting cache image against key(url) not working")
    }
}
