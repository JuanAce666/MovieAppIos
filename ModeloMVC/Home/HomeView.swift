//
//  HomeView.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 24/01/24.
//

import UIKit

@objc protocol HomeViewDelegate: AnyObject {
    func homeViewDidTapListButton(_ homeView: HomeView)
    func homeViewDidTapListButton2(_ homeViwe: HomeView)
}

class HomeView: UIView {
    
    @IBOutlet weak var delegate: HomeViewDelegate?
    
    @IBAction private func ButtonLogin(_ sender: UIButton) {
        self.delegate?.homeViewDidTapListButton(self)
    }
    
    
    @IBAction private func ButtonRegister(_ sender: UIButton) {
        self.delegate?.homeViewDidTapListButton2(self)
    }
    
    
}
