//
//  DetailsWS.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 12/03/24.
//

import Foundation
import Alamofire

//MARK: - WebService Details
struct DetailsWS {
  let apiKey = "752cd23fdb3336557bf3d8724e115570"
  let language = "es"
  let baseURL = "https://api.themoviedb.org/3/movie/"
  func fetch(idMovie: Int, completionHandler: @escaping CompletionHandler) {
    let urlString = "\(baseURL)\(idMovie)?api_key=\(apiKey)&language=\(language)"
    AF.request(urlString, method: .get).response {
      dataResponse in
      guard let data = dataResponse.data else { return }
      do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(DetailDTO.self, from: data) as DetailDTO
        completionHandler(response)
      } catch {
        print("Error decoding JSON: \(error)")
          completionHandler(DetailDTO(genres: [], backdrop_path: "", poster_path: "", release_date: "", original_title: "", overview: "",vote_average: 0))
      }
    }
  }
}
    
extension DetailsWS {
    typealias CompletionHandler = (_ arrayDetailsDTO: DetailDTO) -> Void
    
    struct DetailsResponseDTO: Decodable {
        let results: [DetailDTO]?
    }
    
    struct DetailDTO: Decodable {
        let genres: [GenreDTO]?
        let backdrop_path: String?
        let poster_path: String?
        let release_date: String?
        let original_title: String?
        let overview: String?
        let vote_average: Float?
    }
    
    struct GenreDTO: Decodable {
        let id: Int?
        let name: String?
    }
}
