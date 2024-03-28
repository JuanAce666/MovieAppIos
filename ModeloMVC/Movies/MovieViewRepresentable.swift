//
//  MovieViewRepresentable.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 13/03/24.
//

import SwiftUI

struct MovieViewRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        MoviesViewController.buildGrill()
    }
}

struct MovieViewPreview: PreviewProvider {
    static var previews: some View {
        MovieViewRepresentable()
    }
}
