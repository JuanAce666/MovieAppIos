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
    }
    
    @objc private func addToFavorites() {
        guard let movieDetail = movie else { return }
        // Crea una instancia de tu entidad Movie en el contexto de CoreData
        let movieEntity = MoviesFavoriteCD(context: context)
        // Configura las propiedades de la entidad
        movieEntity.lblName = movieDetail.original_title
        movieEntity.idMovies = Int64(movieDetail.id)
        movieEntity.lblRelaseDate = movieDetail.release_date
        movieEntity.imgMovie = movieDetail.poster_path
        // Guarda el contexto para persistir los cambios en la base de datos
        do {
            try context.save()
            // Cambia la imagen del botón para mostrar que la película es favorita
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
            // Muestra algún mensaje o feedback al usuario
            print("La película ha sido agregada a favoritos.")
        } catch {
            // Manejar el error aquí
            print("Error al guardar la película en favoritos: \(error)")
        }
    }
    
    private func setupFavoriteButton() {
        let favoritesButtonImage = createFavoriteIcon()
        let favoritesButton = UIBarButtonItem(image: favoritesButtonImage, style: .plain, target: self, action: #selector(addToFavorites))
        navigationItem.rightBarButtonItem = favoritesButton
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),style: .plain, target: self, action: #selector(buttonToBack))
        navigationItem.leftBarButtonItem = leftButton
    }
    @objc private func buttonToBack() {
        self.navigationController?.popViewController(animated: true)
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

