//
//  File.swift
//  DetectTouchWindow
//
//  Created by pribit on 3/10/25.
//

import Foundation
import Combine
public actor DetectTouchObservableObject{
    public var isTouching: AnyPublisher<Bool, Never>
    private let isTouchingSubject: CurrentValueSubject<Bool, Never> = .init(false)
    static public let shared: DetectTouchObservableObject = DetectTouchObservableObject()
    
    private init(){
        isTouching = isTouchingSubject.eraseToAnyPublisher()
    }
    
    public func setTouching(_ isTouching: Bool) {
        isTouchingSubject.send(isTouching)
    }
}
