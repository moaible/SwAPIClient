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
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw APIRequestBuildError.invalidBaseURL(url)
        }
        var urlRequest = URLRequest(url: url)
        // get head delete は query parameter、 それ以外は body parameter]
//        throw APIClientError.unknown
        return urlRequest
    }
    
    private static func url<Request: APIRequest>(with request: Request) -> URL {
        return request.path.isEmpty ? request.baseURL : request.baseURL.appendingPathComponent(request.path)
    }
}
