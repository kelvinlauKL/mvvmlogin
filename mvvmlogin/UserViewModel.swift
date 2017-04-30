//
//  UserViewModel.swift
//  ilovetodogigs
//
//  Created by Kelvin Lau on 2017-04-30.
//  Copyright © 2017 ilovetodogigs. All rights reserved.
//

enum UserValidationState {
  case valid
  case invalid(String)
}

struct UserViewModel {
  fileprivate let minUsernameLength = 4
  fileprivate let minPasswordLength = 5
  fileprivate var user = User()
  
  var username: String {
    return user.username
  }
  
  var password: String {
    return user.password
  }
  
  var protectedUsername: String {
    let characters = username.characters
    
    if characters.count >= minUsernameLength {
      var displayName: [Character] = []
      for (index, character) in characters.enumerated() {
        if index > characters.count - minUsernameLength {
          displayName.append(character)
        } else {
          displayName.append("*")
        }
      }
      return String(displayName)
    }
    return username
  }
}

extension UserViewModel {
  mutating func updateUsername(username: String) {
    user.username = username
  }
  
  mutating func updatePassword(password: String) {
    user.password = password
  }
  
  func validate() -> UserValidationState {
    if user.username.isEmpty || user.password.isEmpty {
      return .invalid("Username and password are required")
    }
    
    if user.username.characters.count < minUsernameLength {
      return .invalid("Username needs to be at least \(minUsernameLength) characters long.")
    }
    
    if user.password.characters.count < minPasswordLength {
      return .invalid("Password needs to be at least \(minPasswordLength) characters long.")
    }
    
    return .valid
  }
  
  func login(completion: @escaping (_ errorString: String?) -> ()) {
    LoginService.login(username: user.username, password: user.password) { success in
      if success {
        completion(nil)
      } else {
        completion("Invalid credentials.")
      }
    }
  }
}
