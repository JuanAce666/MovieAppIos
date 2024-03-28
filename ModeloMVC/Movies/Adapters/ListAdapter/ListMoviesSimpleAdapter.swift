//
//  ListMoviesAdapter.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 1/03/24.
//

import UIKit

// Clase que implementa el protocolo listMoviesAdapterProtocol
class ListMoviesSimpleAdapter: NSObject, listMoviesAdapterProtocol {
    // Vista de colección donde se mostrarán las películas y es debil para evitar posibles fugas de memoria
    private unowned var collectionView: UICollectionView?

    // Manejador de selección de películas, se convierte en un callback
    private var didSelect: ((_ movie: Movie) -> Void)?

    // Origen de datos de las películas
    var datasource = [Any]() {
        didSet {
            self.datasource is [Movie] ? self.setCarsLayout() : self.setErrorLayout()
        }
    }

    //configurando el collectionView para mostrar las peliculas 
    func setCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        //Maneja lo que va a mostrar las peliculas
        collectionView.dataSource = self
        self.collectionView = collectionView
        // Configura el diseño de las celdas en la collectionView
        self.setCarsLayout()
        // Registra una celda personalizada llamada "MovieCollectionViewCell" para su uso en el UICollectionView.
        self.collectionView?.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
        self.collectionView?.register(UINib(nibName: "ErrorCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ErrorCollectionViewCell")
        //TODO: - registrar los tipos de celdas
    }
    
    
    
    //Define un método para establecer un callback de selección de película
    func didSelectHandler(_ handler: @escaping (_ movie: Movie) -> Void) {
        // se le asigna ese closure al didselect para que se pueda llamar cuando sea necesario
        self.didSelect = handler
    }
    
    private func setCarsLayout() {
        //definir lauout con dimension de la celda
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        //definir un grupo en horizontal o vertical segun la direccion del scroll es un conjunto de items
        let layoutGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(20)
        //definir la seccion que es un conjunto de grupos
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)
        section.interGroupSpacing = 20
        //creas el layout del collection y se lo asigna
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionView?.collectionViewLayout = layout
    }
    
    
    private func setErrorLayout() {
        //definir lauout con dimension de la celda
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        //definir un grupo en horizontal o vertical segun la direccion del scroll es un conjunto de items
        let layoutGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
        group.interItemSpacing = .fixed(0)
        //definir la seccion que es un conjunto de grupos
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 0
        //creas el layout del collection y se lo asigna
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.collectionView?.collectionViewLayout = layout
    }
}

extension ListMoviesSimpleAdapter: UICollectionViewDataSource {
    //Devuelve el número de elementos en la sección especificada
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Retorna la cantidad de elementos
        self.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.datasource[indexPath.row]
        
        if let message = item as? String {
            return ErrorCollectionViewCell.buildIn(collectionView, in: indexPath, with: message)
        }else if let movie = item as? Movie {
            return  FavoriteCollectionViewCell.buildIn(collectionView, in: indexPath, with: movie)
        }else {
            return UICollectionViewCell()
        }
    }
}

extension ListMoviesSimpleAdapter: UICollectionViewDelegate {
    // Se llama cuando se selecciona un elemento en la vista
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Llama al handler de selección con la película correspondiente en el índice seleccionado
        guard let movie = self.datasource[indexPath.row] as? Movie else { return }
        self.didSelect?(movie)
    }
}

