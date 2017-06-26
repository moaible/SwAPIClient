//
//  APIRequestParameterEncoding.swift
//  SwAPIClientTests
//
//  Created by Hiromi Motodera on 6/26/17.
//

import Foundation

public protocol APIRequestParameterEncoding {
    
    func encode(_ request: URLRequest, parameters: APIRequestParameter?) throws -> URLRequest
}

public struct URLEncoding: APIRequestParameterEncoding {
    
    public enum Error: Swift.Error {
        case missingURL
        case failedCastParameter(APIRequestParameter?)
    }
    
    public func encode(_ request: URLRequest, parameters: APIRequestParameter?) throws -> URLRequest {
        var request = request
        guard let url = request.url else {
            throw Error.missingURL
        }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return request
        }
        guard let queryParameters = parameters.requestParameterValue() as? [String: Any] else {
            return request
        }
        components.percentEncodedQuery = self.string(from: queryParameters)
        request.url = components.url
        return request
    }
    
    public func string(from dictionary: [String: Any]) -> String {
        let pairs = dictionary.map { key, value -> String in
            if value is NSNull {
                return "\(escape(key))"
            }
            
            let valueAsString = (value as? String) ?? "\(value)"
            return "\(escape(key))=\(escape(valueAsString))"
        }
        
        return pairs.joined(separator: "&")
    }
}

public struct JSONEncoding: APIRequestParameterEncoding {
    
    public func encode(_ request: URLRequest, parameters: APIRequestParameter?) throws -> URLRequest {
        var request = request
        guard JSONSerialization.isValidJSONObject(parameters.requestParameterValue()) else {
            throw APIClientError.parseCheckError
        }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters.requestParameterValue(), options: []) else {
            throw APIClientError.parseCheckError
        }
        request.httpBody = jsonData
        return request
    }
}

// MARK: - Private

private func escape(_ string: String) -> String {
    // Reserved characters defined by RFC 3986
    // Reference: https://www.ietf.org/rfc/rfc3986.txt
    let generalDelimiters = ":#[]@"
    let subDelimiters = "!$&'()*+,;="
    let reservedCharacters = generalDelimiters + subDelimiters
    
    var allowedCharacterSet = CharacterSet()
    allowedCharacterSet.formUnion(.urlQueryAllowed)
    allowedCharacterSet.remove(charactersIn: reservedCharacters)
    
    // Crashes due to internal bug in iOS 7 ~ iOS 8.2.
    // References:
    //   - https://github.com/Alamofire/Alamofire/issues/206
    //   - https://github.com/AFNetworking/AFNetworking/issues/3028
    // return string.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? string
    let batchSize = 50
    var index = string.startIndex
    
    var escaped = ""
    
    while index != string.endIndex {
        let startIndex = index
        let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
        let range = startIndex..<endIndex
        
        let substring = string.substring(with: range)
        
        escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? substring
        
        index = endIndex
    }
    
    return escaped
}
