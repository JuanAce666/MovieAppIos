//
//  MoviesViewController.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 27/02/24.
//

import UIKit
// Moviesviewcontroller ahora es el Viewcontroller es quien basicamente se conecta con la capa de datos y le dice a la ui que mostrar

class MoviesViewController: UIViewController {
    
    private var strategy: MovieStrategyProtocol
    private var movieView: MoviesView
    private var movies: [Movie] = []
    private lazy var webServices = MoviesWS()
    private var shouldLoadMoviesOnInit: Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.movieView
        self.navigationItem.title = "Movies"
        self.movieView.delegate = self
        // Método que se encargará de configurar adaptadores y configuraciones.
        self.movieView.setupAdapters()
        
        if shouldLoadMoviesOnInit {
            strategy.getMovies()
        }
        
        // Registrarse para recibir notificaciones de actualización de favoritos
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoritesUpdatedNotification), name: Notification.Name("FavoritesUpdated"), object: nil)
    }
    
    private func getAll() {
        self.movieView.showLoading(true)
        self.webServices.fetch { arrayMovieDTO in
            self.movieView.showLoading(false)
            self.movieView.reloadData(arrayMovieDTO.toMovie)
        }
    }
    
    func loadFavorites() {
        strategy.getMovies()
    }
    
    init(movieView: MoviesView, strategy: MovieStrategyProtocol, shouldLoadMoviesOnInit: Bool) {
        self.movieView = movieView
        self.strategy = strategy
        self.shouldLoadMoviesOnInit = shouldLoadMoviesOnInit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    private func selectedImage(_ movie: Movie) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailsVC.movieId = movie.id
        detailsVC.movie = movie
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    @objc private func handleFavoritesUpdatedNotification() {
        // Actualizar la vista según sea necesario
        strategy.getMovies()
    }
}

extension MoviesViewController: MovieViewDelegate {
    func movieViewStartPullToRefresh(_ movieView: MoviesView) {
        self.getAll()
    }
    
    func movieView(_ movieView: MoviesView, didselectMovie movie: Movie) {
        self.selectedImage(movie)
    }
}
