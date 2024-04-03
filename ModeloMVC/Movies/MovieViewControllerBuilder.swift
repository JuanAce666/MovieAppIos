//
//  MovieViewControllerBuilder.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 13/03/24.
//

import UIKit

extension MoviesViewController {
    class func buildSimple() -> MoviesViewController {
        let movieView = MoviesView(listAdapter: ListMoviesSimpleAdapter(), searchAdapter: SearchMovieByInfoAdapter())
        let controller = MoviesViewController(movieView: movieView, strategy: FavoritesStrategy(movieView: movieView), shouldLoadMoviesOnInit: true)
        return controller
    }
    
    class func buildGrill() -> MoviesViewController {
        let movieView = MoviesView(listAdapter: ListMovieGrillAdapter(), searchAdapter: SearchMovieByNameYearAdapter())
        let controller = MoviesViewController(movieView: movieView, strategy: MovieStrategy(movieView: movieView), shouldLoadMoviesOnInit: true)
        return controller
    }
}
