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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.movieView
        self.movieView.delegate = self
        //metodo que se encargara de configurar adaptadores y configuraciones.
        self.movieView.setupAdapters()
        //llamamos al metodo getall para obtener todas las peliculas
        self.getAll()
       
    }
    
    //esta funcion se encarga de obtener datos relacionados con las peliculas a traves del un servicio web
    private func getAll () {
        self.movieView.showLoading(true)
        // Llama al método fetch del objeto webServices para obtener datos de películas.
            self.webServices.fetch { arrayMovieDTO in
                self.movieView.showLoading(false)
            // Convierte los datos obtenidos (arrayMovieDTO) a objetos Movie y actualiza la interfaz de usuario.
            self.movieView.reloadData(arrayMovieDTO.toMovie)
        }
    }
    
    init(movieView: MoviesView, Movies: MovieStrategyProtocol) {
        self.strategy = Movies
        self.movieView = movieView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    private func selectedImage(_ movie: Movie) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            detailsVC.movieId = movie.id
            self.navigationController?.pushViewController(detailsVC, animated: true)
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
