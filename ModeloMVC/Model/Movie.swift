//
//  Movie.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 27/02/24.
//

import Foundation

// Definición de la estructura Movie, que representa una película en el modelo de negocios
class Movie {
  var original_title: String = ""
  var poster_path: String = ""
  var release_date: String = ""
  var vote_average: Float = 0.0
  var id: Int = 0
    
    // Constructor que inicializa una instancia de Movie a partir de un objeto MovieDTO
    init(dto: MoviesWS.MovieDTO) {
        //Asigna los valores de las propiedades de Movie con los valores correspondientes de MovieDTO
        self.original_title = dto.original_title ?? "--"
        self.release_date = dto.release_date ?? "--"
        self.poster_path = dto.poster_path ?? "--"
        self.vote_average = dto.vote_average ?? 0.0
        self.id = dto.id ?? 0
    }
    
    init(from favoriemovie: MoviesFavoriteCD) {
        self.original_title = favoriemovie.lblName ?? ""
        self.poster_path = favoriemovie.imgMovie ?? ""
        self.release_date = favoriemovie.lblRelaseDate ?? ""
        self.id = Int(favoriemovie.idMovies)
    }
 }

// se hace una extension de array donde los elementos sean igual a MovieDTO
extension Array where Element == MoviesWS.MovieDTO {
// Propiedad computada que convierte un arreglo de MovieDTO a un arreglo de Movie
    var toMovie: [Movie] {
// Utiliza map para transformar cada MovieDTO en una instancia de Movie.
        self.map({Movie (dto: $0)})
    }
}

extension Array where Element == MoviesFavoriteCD {
// Propiedad computada que convierte un arreglo de MovieDTO a un arreglo de Movie
    var toMoviesToFavoritesMovies: [Movie] {
// Utiliza map para transformar cada MovieDTO en una instancia de Movie.
        self.map({Movie (from: $0)})
    }
}
