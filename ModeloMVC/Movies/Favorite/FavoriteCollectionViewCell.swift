//
//  MovieCollectionViewCell.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 27/02/24.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imgMovie: UIImageView!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblRelaseDate: UILabel!
    
    
    fileprivate func updateDataWith(_ movie: Movie) {
        let baseURLImage = "https://image.tmdb.org/t/p/w500"
        let urlImage = baseURLImage + movie.poster_path
        guard let url = URL(string: urlImage) else {return}
        // Crear y manejar la solicitud de datos de la imagen
            URLSession.shared.dataTask(with: url) {(data, response, error) in guard let imageData = data else { return }
              DispatchQueue.main.async {
                self.imgMovie.image = UIImage(data: imageData)
              }
            }.resume()
              self.lblName.text = movie.original_title
              self.lblRelaseDate.text = movie.release_date
          }
        }

extension FavoriteCollectionViewCell {
    // Propiedad de clase que devuelve el identificador de la celda de colección.
    class var indentifier: String { "FavoriteCollectionViewCell" }
    
    // Método de clase que construye y configura una celda de colección para mostrar una película.
    class func buildIn(_ collectionView: UICollectionView, in indexPath: IndexPath, with movie: Movie) -> Self {
        // Obtener una celda reutilizable del collectionView utilizando el identificador.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.indentifier, for: indexPath) as? Self
        
        // Actualizar la celda con la información de la película.
        cell?.updateDataWith(movie)
        
        // Devolver la celda construida, o una instancia nueva de Self si no se puede obtener la celda reutilizable.
        return cell ?? Self()
    }
}
