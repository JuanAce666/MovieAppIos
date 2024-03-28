//
//  TapBarControllerViewController.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 13/03/24.
//

import UIKit

class TapBarControllerViewController: UITabBarController {

        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Crear instancias de los controladores de vista para las pestañas
            let secondVC = MoviesViewController.buildSimple()
            let firstVC = MoviesViewController.buildGrill()
         
            // Configurar los íconos y títulos de las pestañas
            firstVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "square.grid.2x2"), selectedImage: UIImage(systemName: "square.grid.2x2"))
            secondVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star"))
            
            // Establecer los controladores de vista en las pestañas
            viewControllers = [firstVC, secondVC]
    }
}

