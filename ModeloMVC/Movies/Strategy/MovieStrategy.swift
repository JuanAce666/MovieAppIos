//
//  MovieStrategy.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 21/03/24.
//

import UIKit

struct MovieStrategy: MovieStrategyProtocol {
    private var movieView: MoviesView
    private lazy var webServices = MoviesWS()
    
    
    init(movieView: MoviesView) {
        self.movieView = movieView
    }
    
   mutating func getMovies() {
       self.movieView.showLoading(true)
       self.webServices.fetch {[self] MoviesResponseDTO in
           self.movieView.showLoading(false)
           self.movieView.reloadData(MoviesResponseDTO.toMovie)
        }
    }
}

