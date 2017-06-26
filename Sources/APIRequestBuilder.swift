//
//  APIRequestBuilder.swift
//  SwiftyAPIRequest
//
//  Created by Hiromi Motodera on 2017/06/22.
//
//

import Foundation

enum APIRequestBuildError: Error {
    case invalidBaseURL(URL)
}

struct APIRequestBuilder {
    
    static func build<Request: APIRequest>(with request: Request) throws -> URLRequest {
        let url = self.url(with: request)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        request.httpHeaderFields.forEach { (key: String, value: String) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return try request.parameterEncoding.encode(urlRequest, parameters: request.parameters)
    }
    
    static func url<Request: APIRequest>(with request: Request) -> URL {
        return request.path.isEmpty ? request.baseURL : request.baseURL.appendingPathComponent(request.path)
    }
}
