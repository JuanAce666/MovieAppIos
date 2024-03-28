//
//  MoviesWS.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 27/02/24.
//

import Foundation
import Alamofire


//MARK: - WebServices
struct MoviesWS {
    let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c&language=es"
    func fetch(completionHandler: @escaping CompletionHandler)  {
        AF.request(self.urlString, method: .get).response { dataResponse in
            guard let data = dataResponse.data else { return }
            let responseDTO = try? JSONDecoder().decode(MoviesResponseDTO.self, from: data)
            completionHandler(responseDTO?.results ?? [])
        }
    }
}

//MARK: - Cloruses - and DTO
extension MoviesWS {
    typealias CompletionHandler = (_ arrayMoviesDTO: [MovieDTO]) -> Void
    
    struct MoviesResponseDTO: Decodable {
        let results: [MovieDTO]?
    }
    struct MovieDTO: Decodable {
        let adult: Bool?
        let backdrop_path: String?
        let genre_ids: [Int]?
        let id: Int?
        let original_language: String?
        let original_title: String?
        let overview: String?
        let popularity: Float?
        let poster_path: String?
        let release_date: String?
        let title: String?
        let video: Bool?
        let vote_average: Float?
        let vote_count: Float?
    }
}

