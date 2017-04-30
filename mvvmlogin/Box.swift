//
//  Box.swift
//  mvvmlogin
//
//  Created by Kelvin Lau on 2017-04-30.
//  Copyright © 2017 ilovetodogigs. All rights reserved.
//

class Box<T> {
  typealias Listener = (T) -> Void
  var listener: Listener?
  
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  init(_ value: T) {
    self.value = value
  }
  
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
