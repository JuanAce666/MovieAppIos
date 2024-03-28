//
//  ListMovieAdapterProtocol.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 13/03/24.
//

import UIKit

// Protocolo para definir los requisitos de un adaptador de lista de películas en un collectionView
protocol listMoviesAdapterProtocol: AnyObject {
    
    var datasource: [Any] {get set}
    func setCollectionView(_ collectionView: UICollectionView)
    // aca estamos pasando como parametro el hanlder que se va a ejecutar cuando se seleccione una pelicula
    func didSelectHandler(_ handler: @escaping (_ movie: Movie) -> Void)
}
