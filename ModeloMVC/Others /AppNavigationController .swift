//
//  AppNavigationController .swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 12/03/24.
//

import UIKit

class AppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creamos una instancia del controlador de vista de la barra de pestañas
        let tabBarController = TapBarControllerViewController()
        
        // Agregamos el controlador de vista de la barra de pestañas a la pila de navegación
        pushViewController(tabBarController, animated: false)
    }
}
