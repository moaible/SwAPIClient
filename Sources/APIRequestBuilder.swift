//
//  APIRequestBuilder.swift
//  XwireAd
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
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw APIRequestBuildError.invalidBaseURL(url)
        }
        var urlRequest = URLRequest(url: url)
        if let queryParameters = self.queryParameters(with: request) {
            components.percentEncodedQuery = URLEncodedSerialization.string(from: queryParameters)
        }
        urlRequest.url = components.url
        urlRequest.httpMethod = request.method.rawValue
        request.httpHeaderFields.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
    
    private static func url<Request: APIRequest>(with request: Request) -> URL {
        return request.path.isEmpty ? request.baseURL : request.baseURL.appendingPathComponent(request.path)
    }
    
    private static func queryParameters<Request: APIRequest>(with request: Request) -> [String: Any]? {
        guard let parameters = request.parameters.parameterValue() as? [String: Any], [.get, .delete, .head].contains(request.method) else {
            return nil
        }
        
        return parameters
    }
}
