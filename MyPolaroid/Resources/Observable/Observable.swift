//
//  Observable.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import Foundation

class Observable<T> {
    
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bindAndFire(closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
    
    func bind(closure: @escaping (T) -> Void) {
        self.closure = closure
    }
}
