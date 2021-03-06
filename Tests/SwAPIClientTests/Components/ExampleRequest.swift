//
//  ExampleRequest.swift
//  SwiftyAPIRequestTests
//
//  Created by Hiromi Motodera on 2017/06/23.
//

import Foundation
@testable import SwiftyAPIRequest

struct ExampleGETRequest: APIRequest {
    
    typealias Response = Bool
    
    var baseURL: URL {
        return URL(string: "http://example.com")!
    }
    
    var path: String {
        return "/get"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameterFields: APIRequestParameterDictionary? {
        return ["test": "value1"]
    }
    
    func parse(for data: Data, response: HTTPURLResponse) throws -> Response {
        return true
    }
    
    func mockResponse() -> Response {
        return false
    }
}
