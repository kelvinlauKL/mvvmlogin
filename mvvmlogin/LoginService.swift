//
//  LoginService.swift
//  ilovetodogigs
//
//  Created by Kelvin Lau on 2017-04-30.
//  Copyright © 2017 ilovetodogigs. All rights reserved.
//

enum LoginService {
  static func login(username: String, password: String, completion: @escaping (Bool) -> ()) {
    completion(true)
  }
}
