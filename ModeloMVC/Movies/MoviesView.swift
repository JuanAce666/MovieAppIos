//
//  MoviesView.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 27/02/24.
//

import UIKit

// Protocolo para el delegado de la vista de películas
protocol MovieViewDelegate: AnyObject {
    func movieView(_ movieView: MoviesView, didselectMovie movie: Movie)
    func movieViewStartPullToRefresh(_ movieView: MoviesView)
}

class MoviesView: UIView {
    
    // Collection view para mostrar las películas
    private lazy var clvMovies: UICollectionView = {
        let clv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        clv.backgroundColor = .white
        clv.showsVerticalScrollIndicator = false
        clv.translatesAutoresizingMaskIntoConstraints = false
        clv.keyboardDismissMode =  .onDrag
        return clv
    } ()
    
    private lazy var refreshControl: UIRefreshControl = {
       let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.pulltoRefresh(_:)), for: .valueChanged)
        return refresh
    }()
    
    private lazy var srcMovies: UISearchBar = {
        let src = UISearchBar(frame: .zero)
        src.translatesAutoresizingMaskIntoConstraints = false // para habilitar los constraints para compartir frames a constraints
        return src
    }()
    
    weak var delegate: MovieViewDelegate?
    private var listAdapter: listMoviesAdapterProtocol?
    private var searchAdapter: SearchMovieAdapterProtocol?
    
    // Inicializador que recibe un adaptador de lista de películas
    init(listAdapter: listMoviesAdapterProtocol, searchAdapter: SearchMovieAdapterProtocol) {
        self.listAdapter = listAdapter
        self.searchAdapter = searchAdapter
        super.init(frame: .zero)
        self.addElements()
    }
    
    // Inicializador requerido por Storyboard
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addElements()
    }
    
    // Inicializador requerido por Storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addElements()
    }
    
    // Configura el adaptador y maneja la selección de películas
    func setupAdapters() {
        self.listAdapter?.setCollectionView(self.clvMovies)
        self.searchAdapter?.setSearchBar(self.srcMovies)
        self.clvMovies.addSubview(self.refreshControl)
        
        self.listAdapter?.didSelectHandler { movie in
            self.delegate?.movieView(self, didselectMovie: movie)
        }
        self.searchAdapter?.didFilterHandler({ result in
            self.reloadCollectionView(result)
        })
    }
    
    func showLoading(_ isShow: Bool) {
        isShow ? self.refreshControl.beginRefreshing() : self.refreshControl.endRefreshing()
    }
    
    private func reloadCollectionView(_ datasource: [Any]) {
        self.listAdapter?.datasource = datasource
        self.clvMovies.reloadData()
    }
    
    // Recarga los datos del collection view con una nueva lista de películas
    func reloadData(_ datasource: [Movie]) {
        self.searchAdapter?.datasource = datasource
        self.reloadCollectionView(datasource)
        
    }
    
    
    @objc private func pulltoRefresh(_ refreshControl: UIRefreshControl) {
        self.delegate?.movieViewStartPullToRefresh(self)
    }
    
    // Agrega los elementos visuales a la vista
    func addElements() {
        self.backgroundColor = .white
        self.addSubview(self.clvMovies)
        self.addSubview(self.srcMovies)
        
        NSLayoutConstraint.activate([
            self.srcMovies.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.srcMovies.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.srcMovies.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.clvMovies.topAnchor.constraint(equalTo: self.srcMovies.bottomAnchor),
            self.clvMovies.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.clvMovies.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.clvMovies.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
