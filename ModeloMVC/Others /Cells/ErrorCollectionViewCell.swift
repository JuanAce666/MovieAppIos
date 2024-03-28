//
//  ErrorCollectionViewCell.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 18/03/24.
//

import UIKit

class ErrorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var lblMessage: UILabel!
    
   fileprivate func updateDataWith(_ text: String) {
       self.lblMessage.text = text 
    }
}

extension ErrorCollectionViewCell {
    // Propiedad de clase que devuelve el identificador de la celda de colección.
    class var indentifier: String { "ErrorCollectionViewCell" }
    
    // Método de clase que construye y configura una celda de colección para mostrar una película.
    class func buildIn(_ collectionView: UICollectionView, in indexPath: IndexPath, with text: String) -> Self {
        // Obtener una celda reutilizable del collectionView utilizando el identificador.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.indentifier, for: indexPath) as? Self
        
        // Actualizar la celda con la información de la película.
        cell?.updateDataWith(text)
        
        // Devolver la celda construida, o una instancia nueva de Self si no se puede obtener la celda reutilizable.
        return cell ?? Self()
    }
}

