//
//  ObservableObject.swift
//  MirianMaglakelidze#21
//
//  Created by Admin on 3/3/23.
//

import Foundation

final class ObservableObject<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T?) -> ())?
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?) -> Void) {
        self.listener = listener
        listener(value)
    }
}
