//
//  APIRequestParameterArray.swift
//  SwiftyAPIRequest
//
//  Created by Hiromi Motodera on 2017/06/23.
//

import Foundation

public struct APIRequestParameterArray: APIRequestParameter {
    
    var values: [APIRequestParameter] = []
    
    public init(_ values: [APIRequestParameter]) {
        self.values = values
    }
    
    public func requestParameterValue() -> APIRequestParameter {
        return self.values.map({
            return $0.requestParameterValue()
        })
    }
}
