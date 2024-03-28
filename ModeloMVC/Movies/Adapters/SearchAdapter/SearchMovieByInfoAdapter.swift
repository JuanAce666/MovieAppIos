//
//  SearchMovieByInfoAdapter.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 18/03/24.
//

import UIKit

class SearchMovieByInfoAdapter: NSObject, SearchMovieAdapterProtocol {
    var datasource: [Movie] = []
    private var didFilter: ((_ result: [Any]) -> Void)?
    
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self 
    }
    
    func didFilterHandler(_ handler: @escaping ([Any]) -> Void) {
        self.didFilter = handler
    }
    
    
}

extension SearchMovieByInfoAdapter: UISearchBarDelegate {
    //se va a llamar cuando se detecte un cambio en la barra de busquedad
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var arrayResult: [Any] = []
        let searchTextLowercased = searchText.lowercased()
        
        if searchTextLowercased.isEmpty {
            arrayResult = self.datasource
        }else {
            arrayResult = self.datasource.filter({
                $0.original_title.lowercased().contains(searchText.lowercased())
            })
            arrayResult = !arrayResult.isEmpty ? arrayResult : ["""
            No results were found for the search for:
            \(searchText)
            """]
        }
        self.didFilter?(arrayResult)
    }
}
