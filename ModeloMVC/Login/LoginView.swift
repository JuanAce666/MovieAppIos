//
//  LoginView.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 16/01/24.
//

import UIKit

@objc protocol LoginViewDelegate: AnyObject{
    func loginView2(_ loginView: LoginView, doLoginWith user: String?)
    func sendToRegister(_ loginView: LoginView)
}

class LoginView: UIView, UITextFieldDelegate {
    
    @IBOutlet private weak var delegate: LoginViewDelegate?
    
    @IBAction private func tapToCloseKeyboard (_ gesture: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @IBOutlet private weak var txtUsuario: UITextField!
 

    @IBAction private func clickBtnLogin(_ sender: Any) {
        let user = self.txtUsuario.text
        self.delegate?.loginView2(self, doLoginWith: user)
    }



    
    @IBAction func ClickRegisterHere(_ sender: UIButton) {
        self.delegate?.sendToRegister(self)
    }
    
    
    func cambiarEstiloTxtUsuario() {
          txtUsuario.layer.borderWidth = 1.0
          txtUsuario.layer.borderColor = UIColor.black.cgColor
          txtUsuario.layer.cornerRadius = 8.0
      }
    
   
    func setupTextRegister() {
         configureTextField(txtUsuario, placeholder: "Username")
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
