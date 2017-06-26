//
//  SwiftyAPIRequest.swift
//  SwiftyAPIRequest
//
//  Created by Hiromi Motodera on 2017/06/22.
//
//

import Foundation
import Result

public enum SwiftyAPIRequestError: Error {
    
    case buildRequestError(Error)
    case responseError(URLRequest, URLResponse?, Error)
    case parseError(URLRequest, HTTPURLResponse, Error)
    case parseCheckError
    case unmatchParseError(URLRequest, URLResponse?)
}

public class SwiftyAPIRequest {
    
    private static let privateShared: SwiftyAPIRequest = {
        return SwiftyAPIRequest()
    }()
    
    public class var shared: SwiftyAPIRequest {
        return privateShared
    }
    
    public var shouldUseMockRequest: Bool = false
    
    public func request<Request: APIRequest>(
        _ request: Request,
        callbackQueue: CallbackQueue? = nil,
        handler: @escaping (Result<Request.Response, SwiftyAPIRequestError>) -> Void = { _ in })
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
            let result: Result<Request.Response, SwiftyAPIRequestError>
            switch (data, urlResponse, error) {
            case (_, _, let error?):
                result = .failure(.responseError(urlRequest, urlResponse, error))
            case (let data?, let urlResponse as HTTPURLResponse, _):
                do {
                    guard request.canParse(for: data, response: urlResponse) else {
                        throw SwiftyAPIRequestError.parseCheckError
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
