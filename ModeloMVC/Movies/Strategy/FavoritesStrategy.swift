//
//  FavoritesStrategy.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 21/03/24.
//

import Foundation
import UIKit
import CoreData

struct FavoritesStrategy: MovieStrategyProtocol {
    
    private var movieView: MoviesView
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(movieView: MoviesView) {
        self.movieView = movieView
    }
    
    mutating func getMovies() {
        let fetchRequest: NSFetchRequest<MoviesFavoriteCD> = MoviesFavoriteCD.fetchRequest()
        do {
            let favoriteMovies = try context.fetch(fetchRequest)
            self.movieView.reloadData(favoriteMovies.toMoviesToFavoritesMovies)
        } catch {
            print("Error al recuperar películas favoritas: \(error)")
        }
    }
}
