//
//  Movie.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 27/02/24.
//

import Foundation
// pasamos la struct para que la ui lo pueda entender le quitamos el dto y el decodable
//tambien le quitamos el opcional

struct Movie  {
//  let adult: Bool?
//  let backdrop_path: String?
//  let genre_ids: [Int]?
//  let id: Int?
//  let original_language: String?
  let original_title: String
//  let overview: String?
//  let popularity: Float?
  let poster_path: String
  let release_date: String
//  let title: String?
//  let video: Bool?
    
//  let vote_average: Float?
//  let vote_count: Float?
 
    
//    generamos un constructor, se recibe un dto o sea el MovieWS. MovieDTO y se le hacen las asignaciones
    init(dto: MoviesWS.MovieDTO) {
        self.original_title = dto.original_title ?? "--"
        self.release_date = dto.release_date ?? "--"
        self.poster_path = dto.poster_path ?? "--"
    }
 }

// se hace una extension de array donde los elementos sean igual a MovieDTO
extension Array where Element == MoviesWS.MovieDTO {
//    se hace una variable computada que se llama toMovie y es de tipo movie se le hace un map
    var toMovie: [Movie] {
        self.map({Movie (dto: $0)})
    }
}
