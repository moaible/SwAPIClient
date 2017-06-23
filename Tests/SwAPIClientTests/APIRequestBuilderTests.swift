//
//  APIRequestBuilderTests.swift
//  SwAPIClientTests
//
//  Created by Hiromi Motodera on 2017/06/23.
//

import XCTest
@testable import SwAPIClient

class APIRequestBuilderTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        do {
            let request: URLRequest = try APIRequestBuilder.build(with: ExampleGETRequest())
            XCTAssertEqual("http://example.com/get", request.url?.absoluteString)
            XCTAssertEqual("", "")
            XCTAssertEqual("", "")
            XCTAssertEqual("", "")
            XCTAssertEqual("", "")
            XCTAssertEqual("", "")
            XCTAssertEqual("", "")
        } catch {
            
        }
    }
}
