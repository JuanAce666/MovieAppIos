//
//  PrincipalViewController.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 31/01/24.
//

import UIKit

class PrincipalViewController: ViewController {
    var principalView: PrincipalView? {
        self.view as? PrincipalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension PrincipalViewController: PrincipalViewDelegate {
    
}
