//
//  HomeViewController.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 24/01/24.
//

import UIKit

class HomeViewController: ViewController {
    
    var homeView: HomeView? {
        self.view as? HomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension HomeViewController: HomeViewDelegate {
    func homeViewDidTapListButton2(_ homeViwe: HomeView) {
        self.performSegue(withIdentifier: "RegisterViewController", sender: nil)
    }
    
    func homeViewDidTapListButton(_ homeView: HomeView) {
        self.performSegue(withIdentifier: "LoginViewController", sender: nil)
    }
    
}
 
