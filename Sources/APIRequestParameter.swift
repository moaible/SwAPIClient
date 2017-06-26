//
//  APIRequestParameter.swift
//  SwAPIClient
//
//  Created by Hiromi Motodera on 6/23/17.
//

import Foundation

public protocol APIRequestParameter {
    
    func requestParameterValue() -> APIRequestParameter
}
