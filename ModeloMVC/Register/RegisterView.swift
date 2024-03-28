//
//  RegisterView.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 31/01/24.
//

import UIKit

@objc protocol RegisterViewDelegate: AnyObject {
    func registerView2(_ registerView: RegisterView, doLoginWith username: String?)
    func sendToLogin(_ registerView: RegisterView)
}

class RegisterView: UIView, UITextFieldDelegate {
    
    @IBOutlet private weak var delegate: RegisterViewDelegate?
    
    @IBAction private func tapToCloseKeyboard (_ gesture: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @IBOutlet private weak var RegisterUsuario: UITextField!
    
    @IBAction func ClickLoginHere(_ sender: UIButton) {
        self.delegate?.sendToLogin(self)
    }
    
    
    @IBAction func RegisterButton(_ sender: Any) {
        let registerUsername = RegisterUsuario.text
        delegate?.registerView2(self, doLoginWith: registerUsername)
    }
    
    
    
    func cambiarEstiloRegisterUsuario() {
          RegisterUsuario.layer.borderWidth = 1.0
          RegisterUsuario.layer.borderColor = UIColor.black.cgColor
          RegisterUsuario.layer.cornerRadius = 8.0
      }
    
    
    func setupTextRegister() {
         configureTextField(RegisterUsuario, placeholder: "Username")
       }
    
    func configureTextField(_ textField: UITextField, placeholder: String) {
        
      let placeholderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
      textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        textField.layer.addSublayer(bottomLine)
        textField.delegate = self
    }
}
