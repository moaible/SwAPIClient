//
//  APIRequestParameterDictionary.swift
//  Result
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
        return dictionary
    }
}

protocol APIRequestParameterDictionaryConvertible: APIRequestParameter {
    
    func requestParameterDictionary() -> APIRequestParameterDictionary
}

extension APIRequestParameterDictionaryConvertible {
    
    func requestParameterValue() -> APIRequestParameter {
        return requestParameterDictionary().requestParameterValue()
    }
}
