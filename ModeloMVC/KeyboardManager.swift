//
//  KeyboardManager.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 7/02/24.
//
import UIKit
//
protocol KeyboardManagerDelegate: AnyObject {
    // Método requerido que se llama cuando el teclado está a punto de mostrarse
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboarWillShowWith info: KeyboardManager.Info)
    // Método requerido que se llama cuando el teclado está a punto de ocultarse
    func keyboardManager(_ keyboardManager: KeyboardManager, keyboarWillHideWith info: KeyboardManager.Info)
}

class KeyboardManager {
    // Declara una propiedad de tipo KeyboardManagerDelegate opcional.
    private unowned let delegate: KeyboardManagerDelegate
    
    init(delegate: KeyboardManagerDelegate) {
        self.delegate = delegate
    }
    
     func registerKeyboardNotifications() {
         // addobserver se suscribiendo a un evento,
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder
                                               .keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder
                                               .keyboardWillShowNotification,
                                                object: nil)
    }
    
    
// aca dejamos de escuchar el teclado
     func unregisterKeyboardNotification () {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder
                                                  .keyboardWillHideNotification
                                                  , object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder
                                                   .keyboardWillShowNotification,
                                                    object: nil)
    }
    
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        let info = KeyboardManager.Info(userInfo: notification.userInfo)
        self.delegate.keyboardManager(self, keyboarWillShowWith: info)
    }
     
    @objc private func keyboardWillHide(_ notification: Notification) {
        let info = KeyboardManager.Info(userInfo: notification.userInfo)
        self.delegate.keyboardManager(self, keyboarWillHideWith: info)
    }
}


extension KeyboardManager {
    struct Info {
        let frame: CGRect
        let animationDuration: Double
        
        fileprivate init(userInfo: [AnyHashable: Any]?) {
            self.frame = userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
            self.animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        }
    }
    
}
