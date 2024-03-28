//
//  Detail.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 12/03/24.
//
import Foundation

struct Detail {
    
    let genres: [DetailsWS.GenreDTO]
    let backdropPath: String
    let posterPath: String
    let releaseDate: String
    let originalTitle: String
    let overview: String
    let vote_average: Float
    
    init(dto: DetailsWS.DetailDTO) {
        self.backdropPath = dto.backdrop_path ?? "--"
        self.posterPath = dto.poster_path ?? "--"
        self.releaseDate = dto.release_date ?? "--"
        self.originalTitle = dto.original_title ?? "--"
        self.overview = dto.overview ?? "--"
        self.vote_average = dto.vote_average ?? 0.0
        
        if let genreDTO = dto.genres, !genreDTO.isEmpty {
            self.genres = genreDTO
        } else {
            self.genres = []
        }
    }
}

extension Array where
    Element == DetailsWS.DetailDTO {
        var toDetails: [Detail] {
        self.map({Detail(dto: $0)})
    }
}
