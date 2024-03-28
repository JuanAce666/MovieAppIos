//
//  MovieViewControllerBuilder.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 13/03/24.
//

import UIKit

extension MoviesViewController {
    class func buildSimple() -> MoviesViewController {
        // Creamos una instancia de MoviesView con un adaptador de lista simple
        let movieView = MoviesView(listAdapter: ListMoviesSimpleAdapter(), searchAdapter: SearchMovieByInfoAdapter())
        // Creamos una instancia de MoviesViewController con la vista de películas creada
        let controller = MoviesViewController(movieView: movieView, Movies: FavoritesStrategy(movieView: movieView))
        return controller
    }

    class func buildGrill() -> MoviesViewController {
        // Creamos una instancia de MoviesView con un adaptador de lista de rejilla
        let movieView = MoviesView(listAdapter: ListMovieGrillAdapter(), searchAdapter: SearchMovieByNameYearAdapter())
        // Creamos una instancia de MoviesViewController con la vista de películas creada
        let controller = MoviesViewController(movieView: movieView, Movies: MovieStrategy(movieView: movieView))
        return controller
    }
}
