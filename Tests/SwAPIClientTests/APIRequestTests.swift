//
//  APIRequestTests.swift
//  ios-inhouse-sdkTests
//
//  Created by Hiromi Motodera on 2017/06/23.
//

import XCTest
@testable import SwAPIClient

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
        XCTAssertEqual((getRequest.parameters as? APIRequestParameterDictionary)?.value["test"] as? String, "value1")
        XCTAssertEqual(try? getRequest.parse(for: Data(), response: HTTPURLResponse()), true)
        XCTAssertEqual(getRequest.mockResponse(), false)
    }
}
