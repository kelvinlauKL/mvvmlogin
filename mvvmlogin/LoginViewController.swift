//
//  LoginViewController.swift
//  mvvmlogin
//
//  Created by Kelvin Lau on 2017-04-30.
//  Copyright © 2017 ilovetodogigs. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
  @IBOutlet fileprivate var emailTextField: UITextField!
  @IBOutlet fileprivate var passwordTextField: UITextField!
  
  var loginSuccess: (() -> Void)?
  fileprivate var viewModel = UserViewModel()
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField == emailTextField {
      textField.text = viewModel.username
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == emailTextField {
      textField.text = viewModel.protectedUsername
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    } else {
      authenticate()
    }
    
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    
    if textField == emailTextField {
      viewModel.updateUsername(username: newString)
    } else if textField == passwordTextField {
      viewModel.updatePassword(password: newString)
    }
    
    return true
  }
}

// MARK: - @IBActions
private extension LoginViewController {
  @IBAction func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @IBAction func authenticate() {
    dismissKeyboard()
    
    switch viewModel.validate() {
    case .valid:
      viewModel.login() { errorMessage in
        if let errorMessage = errorMessage {
          fatalError(errorMessage)
        } else {
          self.loginSuccess?()
        }
      }
    case .invalid(let error):
      fatalError(error)
    }
  }
}
