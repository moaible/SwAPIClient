//
//  APIRequestParameter+Confirm.swift
//  Result
//
//  Created by Hiromi Motodera on 2017/06/23.
//

import Foundation

extension Bool: APIRequestParameter {
    
    public func parameterValue() -> APIRequestParameter {
        return self
    }
}

extension Int: APIRequestParameter {
    
    public func parameterValue() -> APIRequestParameter {
        return self
    }
}

extension Float: APIRequestParameter {
    
    public func parameterValue() -> APIRequestParameter {
        return self
    }
}

extension Double: APIRequestParameter {
    
    public func parameterValue() -> APIRequestParameter {
        return self
    }
}

extension String: APIRequestParameter {
    
    public func parameterValue() -> APIRequestParameter {
        return self
    }
}

extension Array: APIRequestParameter {
    
    public func parameterValue() -> APIRequestParameter {
        return self
    }
}

extension Dictionary: APIRequestParameter {
    
    public func parameterValue() -> APIRequestParameter {
        return self
    }
}


extension NSNull: APIRequestParameter {
    
    public func parameterValue() -> APIRequestParameter {
        return self
    }
}

extension Optional: APIRequestParameter {
    
    public func parameterValue() -> APIRequestParameter {
        guard let bindSelf = self else {
            return NSNull().parameterValue()
        }
        guard let parameter = bindSelf as? APIRequestParameter else {
            fatalError("APIRequestParameterError.castError")
        }
        return parameter.parameterValue()
    }
}
