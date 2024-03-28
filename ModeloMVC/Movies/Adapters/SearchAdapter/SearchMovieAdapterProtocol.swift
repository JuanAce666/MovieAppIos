//
//  SearchMovieAdapterProtocol.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 18/03/24.
//

import UIKit

protocol SearchMovieAdapterProtocol: AnyObject {
    var datasource: [Movie] {get set}
    func setSearchBar(_ searchBar: UISearchBar)
    func didFilterHandler(_ handler: @escaping (_ result:  [Any]) -> Void)
}
