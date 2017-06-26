//
//  CallbackQueue.swift
//  SwAPIClient
//
//  Created by Hiromi Motodera on 2017/06/22.
//
//

import Foundation

public enum CallbackQueue {
    
    case main
    
    case sessionQueue
    
    case dispatchQueue(DispatchQueue)
    
    public func execute(closure: @escaping () -> Void) {
        switch self {
        case .main:
            DispatchQueue.main.async {
                closure()
            }
            
        case .sessionQueue:
            closure()
            
        case .dispatchQueue(let dispatchQueue):
            dispatchQueue.async {
                closure()
            }
        }
    }
}
