//
//  LoginViewController .swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 16/01/24.
//

import UIKit

class LoginViewController: ViewController {
    
    lazy var keyboardManager = KeyboardManager(delegate: self)
    
    var loginView: LoginView? {
        // Esta es una propiedad computada llamada `loginView`.
        // Cuando se accede a esta propiedad, intentará convertir
        // la vista actual (`self.view`) a `LoginView` y devolverá
        // el resultado opcional (puede ser `LoginView` o `nil`).
        self.view as? LoginView
  }
    
    override func viewDidLoad() {
        // Llama al método viewDidLoad() de la superclase UIViewController
        // para ejecutar el comportamiento predeterminado del ciclo de vida
        // de la vista del controlador antes de realizar acciones adicionales.
        super.viewDidLoad()
        loginView?.cambiarEstiloTxtUsuario()
        loginView?.setupTextRegister()
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

extension LoginViewController: KeyboardManagerDelegate {
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboarWillShowWith info: KeyboardManager.Info) {
        print("teclado aparece")
   
    }
    
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboarWillHideWith info: KeyboardManager.Info) {
        print("teclado desaparece")
    }

}




extension LoginViewController: LoginViewDelegate {
    func sendToRegister(_ loginView: LoginView) {
        
    }
    
    
    func loginView2(_ loginView: LoginView, doLoginWith user: String?) {
        guard let user = user, !user.isEmpty else {
            updateUIWithErrorMessage("Please enter your username")
            return
        }
        print("Starting the application...")
    }
    
    private func updateUIWithErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        print(message)
    }
    
}
