//
//  APIRequestParameterTests.swift
//  SwAPIClientTests
//
//  Created by Hiromi Motodera on 6/24/17.
//

import XCTest
@testable import SwAPIClient

class APIRequestParameterTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBoolParameter() {
        XCTAssertEqual(true, true.requestParameterValue() as? Bool)
        XCTAssertEqual(false, false.requestParameterValue() as? Bool)
    }
    
    func testStringParameter() {
        XCTAssertEqual("", "".requestParameterValue() as? String)
        XCTAssertEqual("abc", "abc".requestParameterValue() as? String)
    }
    
    func testDoubleParameter() {
        XCTAssertEqual(0.0 as Double, 0.0.requestParameterValue() as? Double)
        XCTAssertEqual(1.0 as Double, 1.0.requestParameterValue() as? Double)
        XCTAssertEqual(-1.0 as Double, (-1.0).requestParameterValue() as? Double)
    }
    
    func testFloatParameter() {
        XCTAssertEqual(Float(exactly: 0.0), Float(exactly: 0.0).requestParameterValue() as? Float)
        XCTAssertEqual(Float(exactly: 1.0), Float(exactly: 1.0).requestParameterValue() as? Float)
        XCTAssertEqual(Float(exactly: -1.0), Float(exactly: -1.0).requestParameterValue() as? Float)
    }
    
    func testNullParameter() {
        XCTAssertEqual(NSNull().requestParameterValue() as? NSNull, NSNull())
    }
    
    func testOptionalParameter() {
        let optional: DispatchQueue? = DispatchQueue.main
        XCTAssertEqual(optional.requestParameterValue() as? NSNull, NSNull())
    }
}
