//
//  APIRequestParameterDictionary.swift
//  SwAPIClient
//
//  Created by Hiromi Motodera on 2017/06/23.
//

import Foundation

public struct APIRequestParameterDictionary: APIRequestParameter {
    
    /// リクエストパラメーターの扱いについて
    public enum NullReadingOption {
        
        case ignoreNull
        
        case allowNull
    }
    
    var value: [String: APIRequestParameter?]
    
    let readingOption: NullReadingOption
    
    init(_ value: [String: APIRequestParameter?], option: NullReadingOption = .ignoreNull) {
        self.value = value
        self.readingOption = option
    }
    
    public func requestParameterValue() -> APIRequestParameter {
        var dictionary: [String: APIRequestParameter] = [:]
        for (k, v) in value {
            switch self.readingOption {
            case .ignoreNull:
                if let parameter = v?.requestParameterValue() {
                    dictionary[k] = parameter
                }
            case .allowNull:
                dictionary[k] = v?.requestParameterValue() ?? NSNull().requestParameterValue()
            }
        }
        return dictionary.requestParameterValue()
    }
}

extension APIRequestParameterDictionary: ExpressibleByDictionaryLiteral {
    
    public typealias Key = String
    
    public typealias Value = APIRequestParameter?
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self.init(
            elements.reduce([Key : Value](minimumCapacity: elements.count)) {
                (dictionary: [Key : Value], element:(key: Key, value: Value)) -> [Key : Value] in
                var d = dictionary
                d[element.key] = element.value
                return d
        })
    }
}

protocol APIRequestParameterDictionaryConvertible: APIRequestParameter {
    
    func requestParameterDictionary() -> APIRequestParameterDictionary
}

extension APIRequestParameterDictionaryConvertible {
    
    func requestParameterValue() -> APIRequestParameter {
        return self.requestParameterDictionary().requestParameterValue()
    }
}

extension APIRequestParameterDictionary: APIRequestParameterDictionaryConvertible {
    
    func requestParameterDictionary() -> APIRequestParameterDictionary {
        return self
    }
}
