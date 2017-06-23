//
//  APIRequest.swift
//  XwireAd
//
//  Created by Hiromi Motodera on 2017/06/22.
//
//

import Foundation

public enum APIRequestMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case head = "HEAD"
    case delete = "DELETE"
    case patch = "PATCH"
    case trace = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
}

public protocol APIRequest {
    
    associatedtype Response
    
    var baseURL: URL { get }
    
    var method: APIRequestMethod { get }
    
    var path: String { get }
    
    var parameters: APIRequestParameter? { get }
    
    var httpHeaderFields: [String : String] { get }
    
    func canParse(for data: Data, response: HTTPURLResponse) -> Bool
    
    func parse(for data: Data, response: HTTPURLResponse) throws -> Response
    
    func mockResponse() -> Response
}

extension APIRequest {
    
    var parameters: APIRequestParameter? {
        return nil
    }
    
    func canParse(for data: Data, response: HTTPURLResponse) -> Bool {
        guard 200 ..< 300 ~= response.statusCode else {
            return false
        }
        return true
    }
}
