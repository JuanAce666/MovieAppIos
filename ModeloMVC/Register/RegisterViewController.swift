//
//  RegisterViewController.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 31/01/24.
//

import UIKit

class RegisterViewController: ViewController {
    
    lazy var keyboardManager = KeyboardManager(delegate: self)
    
    var registerView: RegisterView? {
        self.view as? RegisterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView?.cambiarEstiloRegisterUsuario()
        registerView?.setupTextRegister()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.keyboardManager.registerKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.keyboardManager.unregisterKeyboardNotification()
    }
}


extension RegisterViewController: KeyboardManagerDelegate {
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboarWillShowWith info: KeyboardManager.Info) {
        print("teclado aparece")
    }
    
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboarWillHideWith info: KeyboardManager.Info) {
        print("teclado desaparece")
    }
}


extension RegisterViewController: RegisterViewDelegate {
    func sendToLogin(_ registerView: RegisterView) {
    }
    
    func registerView2(_ registerView: RegisterView, doLoginWith username: String?) {
        
        guard let user = username, !user.isEmpty else {
            updateUIWithErrorMessage("Please enter your username")
            return
        }
        guard user.count <= 10 else {
            updateUIWithErrorMessage("Your username can only be up to 10 characters long")
            return
        }

        print("Succesful registration")
    }
    
    private func updateUIWithErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Registration Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        print(message)
    }
}
