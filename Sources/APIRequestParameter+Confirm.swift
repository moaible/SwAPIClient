//
//  APIRequestParameter+Confirm.swift
//  Result
//
//  Created by Hiromi Motodera on 2017/06/23.
//

import Foundation

extension Bool: APIRequestParameter {
    
    public func requestParameterValue() -> APIRequestParameter {
        return self
    }
}

extension Int: APIRequestParameter {
    
    public func requestParameterValue() -> APIRequestParameter {
        return self
    }
}

extension Float: APIRequestParameter {
    
    public func requestParameterValue() -> APIRequestParameter {
        return self
    }
}

extension Double: APIRequestParameter {
    
    public func requestParameterValue() -> APIRequestParameter {
        return self
    }
}

extension String: APIRequestParameter {
    
    public func requestParameterValue() -> APIRequestParameter {
        return self
    }
}

extension Array: APIRequestParameter {
    
    public func requestParameterValue() -> APIRequestParameter {
        guard let castSelf = self as? [APIRequestParameter] else {
            return NSNull().requestParameterValue()
        }
        return APIRequestParameterArray(castSelf)
    }
}

extension Dictionary where Key == String, Value == APIRequestParameter {
    
    func requestParameterValue() -> APIRequestParameter {
        return self
    }
}

extension Dictionary: APIRequestParameter {
    
    public func requestParameterValue() -> APIRequestParameter {
        fatalError("Not casting, use 'Dictionary<String, APIRequestParameter>' type")
    }
}

extension NSNull: APIRequestParameter {
    
    public func requestParameterValue() -> APIRequestParameter {
        return self
    }
}

extension Optional: APIRequestParameter {
    
    public func requestParameterValue() -> APIRequestParameter {
        guard let bindSelf = self else {
            return NSNull().requestParameterValue()
        }
        guard let parameter = bindSelf as? APIRequestParameter else {
            return NSNull().requestParameterValue()
        }
        return parameter.requestParameterValue()
    }
}
