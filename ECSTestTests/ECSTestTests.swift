//
//  ECSTestTests.swift
//  ECSTestTests
//
//  Created by Tulasi on 03/08/19.
//  Copyright © 2019 Assignment. All rights reserved.
//

import XCTest
@testable import ECSTest

class ECSTestTests: XCTestCase {
    var sut: URLSession!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func testValidCallToNYTgetMostViewedHTTPSStausCode200() {
        let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=MrB8akGSY5ddGbelEQlSHvOYyZGaLuVK")
        
        let promise = expectation(description: "Status code: 200")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
        
    }

}
