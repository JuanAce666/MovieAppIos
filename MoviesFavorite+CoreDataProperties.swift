//
//  MoviesFavorite+CoreDataProperties.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 21/03/24.
//
//

import Foundation
import CoreData


extension MoviesFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviesFavorite> {
        return NSFetchRequest<MoviesFavorite>(entityName: "MoviesFavorite")
    }

    @NSManaged public var idMovies: Int64
    @NSManaged public var imgMovie: String?
    @NSManaged public var lblName: String?
    @NSManaged public var lblRelaseDate: String?

}

