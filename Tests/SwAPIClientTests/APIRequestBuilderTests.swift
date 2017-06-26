//
//  APIRequestBuilderTests.swift
//  SwiftyAPIRequestTests
//
//  Created by Hiromi Motodera on 2017/06/23.
//

import XCTest
@testable import SwiftyAPIRequest

class APIRequestBuilderTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExampleRequestBuild() {
        do {
            let request: URLRequest = try APIRequestBuilder.build(with: ExampleGETRequest())
            XCTAssertEqual(request.url?.absoluteString, "http://example.com/get?test=value1")
            XCTAssertEqual(request.httpMethod, "GET")
        } catch {
            
        }
    }
}
