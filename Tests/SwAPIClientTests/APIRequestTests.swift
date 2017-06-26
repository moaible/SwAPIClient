//
//  APIRequestTests.swift
//  SwiftyAPIRequestTests
//
//  Created by Hiromi Motodera on 2017/06/23.
//

import XCTest
@testable import SwiftyAPIRequest

class APIRequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExampleGETRequest() {
        let getRequest = ExampleGETRequest()
        XCTAssertEqual(getRequest.baseURL, URL(string: "http://example.com"))
        XCTAssertEqual(getRequest.path, "/get")
        XCTAssertEqual(getRequest.httpHeaderFields, [:])
        XCTAssertEqual(getRequest.method, .get)
        if let dict = getRequest.parameters as? APIRequestParameterDictionary {
            XCTAssertEqual(dict.value["test"] as? String, "value1")
        } else {
            XCTAssert(false)
        }
        XCTAssertEqual(try? getRequest.parse(for: Data(), response: HTTPURLResponse()), true)
        XCTAssertEqual(getRequest.mockResponse(), false)
    }
}
