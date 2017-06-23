//
//  APIClient.swift
//  XwireAd
//
//  Created by Hiromi Motodera on 2017/06/22.
//
//

import Foundation
import Result

public enum APIClientError: Error {
    
    case buildRequestError(Error)
    case responseError(URLRequest, URLResponse?, Error)
    case parseError(URLRequest, HTTPURLResponse, Error)
    case parseCheckError
    case unmatchParseError(URLRequest, URLResponse?)
}

public class APIClient {
    
    private static let privateShared: APIClient = {
        return APIClient()
    }()
    
    public class var shared: APIClient {
        return privateShared
    }
    
    public var shouldUseMockRequest: Bool = false
    
    public func send<Request: APIRequest>(
        request: Request,
        callbackQueue: CallbackQueue? = nil,
        handler: @escaping (Result<Request.Response, APIClientError>) -> Void = { _ in })
    {
        let callbackQueue = callbackQueue ?? .main
        let urlRequest: URLRequest
        do {
            urlRequest = try APIRequestBuilder.build(with: request)
        } catch {
            callbackQueue.execute {
                handler(.failure(.buildRequestError(error)))
            }
            return
        }
        guard !self.shouldUseMockRequest else {
            callbackQueue.execute {
                handler(.success(request.mockResponse()))
            }
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            let result: Result<Request.Response, APIClientError>
            switch (data, urlResponse, error) {
            case (_, _, let error?):
                result = .failure(.responseError(urlRequest, urlResponse, error))
            case (let data?, let urlResponse as HTTPURLResponse, _):
                do {
                    guard request.canParse(for: data, response: urlResponse) else {
                        throw APIClientError.parseCheckError
                    }
                    result = .success(try request.parse(for: data, response: urlResponse))
                } catch {
                    result = .failure(.parseError(urlRequest, urlResponse, error))
                }
            default:
                result = .failure(.unmatchParseError(urlRequest, urlResponse))
            }
            
            callbackQueue.execute {
                handler(result)
            }
        }.resume()
    }
}
