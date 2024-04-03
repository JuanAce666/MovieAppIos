//
//  DetailsViewController.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 12/03/24.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var detailView: DetailsView? { self.view as? DetailsView }
    lazy var webService = MoviesWS()
    lazy var webDetail = DetailsWS()
    
    var movie: Movie?
    var movieId: Int?
    var isFavoriteMovie = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private lazy var webServiceDetail = MoviesWS()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesDetails()
        self.navigationItem.title = "Details"
        // Configurar el botón de favoritos
        setupFavoriteButton()
        checkIfMovieIsFavorite()
    }
    
    private func checkIfMovieIsFavorite() {
        guard let movieId = movie?.id else { return }
        let fetchRequest: NSFetchRequest<MoviesFavoriteCD> = MoviesFavoriteCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idMovies == %d", movieId)
        
        do {
            let results = try context.fetch(fetchRequest)
            isFavoriteMovie = !results.isEmpty
            updateFavoriteButtonImage()
        } catch {
            print("Error al verificar si la película es favorita: \(error)")
        }
    }
    
    @objc private func addToFavorites() {
        guard let movieDetail = movie else {
            print("addToFavorites: La película es nil.")
            return
        }
        
        let fetchRequest: NSFetchRequest<MoviesFavoriteCD> = MoviesFavoriteCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idMovies == %d", movieDetail.id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                // La película no es favorita, agregar a favoritos
                let movieEntity = MoviesFavoriteCD(context: context)
                movieEntity.lblName = movieDetail.original_title
                movieEntity.idMovies = Int64(movieDetail.id)
                movieEntity.lblRelaseDate = movieDetail.release_date
                movieEntity.imgMovie = movieDetail.poster_path
                try context.save()
                isFavoriteMovie = true
                print("addToFavorites: Película agregada a favoritos.")
            } else {
                // La película ya es favorita, eliminar de favoritos
                for object in results {
                    context.delete(object)
                }
                try context.save()
                isFavoriteMovie = false
                print("addToFavorites: Película eliminada de favoritos.")
            }
            
            // Actualiza el estado de favoritos y la interfaz de usuario
            updateFavoriteButtonImage()
            
            // Envía una notificación de que la lista de favoritos ha sido actualizada
            NotificationCenter.default.post(name: Notification.Name("FavoritesUpdated"), object: nil)
            
        } catch {
            print("addToFavorites: Error al modificar favoritos: \(error)")
        }
    }
    
    private func setupFavoriteButton() {
        let favoritesButtonImage = createFavoriteIcon()
        let favoritesButton = UIBarButtonItem(image: favoritesButtonImage, style: .plain, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItem = favoritesButton
    }
    
    private func createFavoriteIcon() -> UIImage {
        return UIImage(systemName: isFavoriteMovie ? "star.fill" : "star") ?? UIImage()
    }
    
    private func updateFavoriteButtonImage() {
        let image = createFavoriteIcon()
        navigationItem.rightBarButtonItem?.image = image
    }
    
    private func getMoviesDetails() {
        guard let movieId = movieId else { return }
        webDetail.fetch(idMovie: movieId) { [weak self] detailDTO in
            let detail = Detail(dto: detailDTO)
            DispatchQueue.main.async {
                self?.detailView?.dataInjection(fromModel: detail)
            }
        }
    }
}
