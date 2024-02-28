//
//  MoviesWS.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 27/02/24.
//

import Foundation
import Alamofire



//MARK: - WebServices
struct MoviesWS {
//    como esta definida como una propiedad no debe de estar alla abajo entonces se pasa, y puede inyectarse cuando se necesite
//    since it is defined as a property it should not be down there so it is passed, and can be injected when needed
    let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=176de15e8c8523a92ff640f432966c9c&language=es"
    
//    funcion para verificar que si este consumiendo el servicio
//    function to verify that the service is being consumed
    
//    dentro de este fetch le pones un callback, pasamos completionHandler se añade el @escaping es un modificador para que el callback pueda esperar su ejecucion
//    inside this fetch you put a callback, we pass completionHandler and add the @escaping, it is a modifier so that the callback can wait for its execution,
    func fetch(completionHandler: @escaping CompletionHandler)  {
//    luego creamos un alamofire. request y pasamos la variable, le pasamos el method que es un get, le pasamos un response que es un completionHandler, luego eso me devuelve una data que es dataResponse, se construye asi porque es una funcion anonima o un callback
// then we create an alamofire. request and we pass the variable, we pass it the method which is a get, we pass it a response which is a completionHandler, then that returns me a data which is dataResponse, it is constructed like this because it is an anonymous function or a callback
        
        AF.request(self.urlString, method: .get).response { dataResponse in
/*    dataResponse me devuelve un data, data es un bloque de 01 de manera opcional, porque puede ser opcional porque puede que no venga informacion
      primero se imprime como diccionario para ver la respuesta con un JSON
      utilizando una declaración guard para desempaquetar de manera segura el valor opcional data
 
*/       
/* dataResponse returns me a data, data is a block of 01 optionally, because it can be optional because there may be no information
                  first print as dictionary to see the response with a JSON
                  using a guard statement to safely unpack the optional data value
*/
        guard let data = dataResponse.data else { return }
            
//    al decode le pasamos el tipo que quiero ser la codificacion, y le pasamos la data, se envia como un array y necesita un try
// to the decode we pass the type that I want to be the encoding, and we pass the data, it is sent as an array and needs a try
            let responseDTO = try? JSONDecoder().decode(MoviesResponseDTO.self, from: data)
            
// Llama al completionHandler con los resultados de la solicitud web.
// Si la respuesta es nula, se pasa un array vacío como valor predeterminado.
// Call the completionHandler with the results of the web request.
// If the response is null, an empty array is passed as the default value.
            completionHandler(responseDTO?.results ?? [])
        }
    }
}

//MARK: - Cloruses - and DTO
extension MoviesWS {
//creamos una extension y le pasamos el typealeas ya creado
//se modifica el handler a arrayMoviesDTO y se le pasa un [] MovieDTO sin errores
//create an extension and pass it the typealias already created
//the handler is modified to arrayMoviesDTO and a [] MovieDTO is passed without errors
    typealias CompletionHandler = (_ arrayMoviesDTO: [MovieDTO]) -> Void
    
// Estructura que representa la respuesta del servicio web
// Structure that represents the response of the web service
    struct MoviesResponseDTO: Decodable {
        let results: [MovieDTO]?
    }
    
// creamos un DTO con una struct y dentro de una extension de MoviesWS
//"Decodable se utiliza para decodificar datos codificados, como objetos JSON, y convertirlos en instancias de una estructura o clase en Swift
// create a DTO with a struct and inside a MoviesWS extension
//Decodable is used to decode encoded data, such as JSON objects, and convert them into instances of a structure or class in Swift
    struct MovieDTO: Decodable {
        let adult: Bool?
        let backdrop_path: String?
        let genre_ids: [Int]?
        let id: Int?
        let original_language: String?
        let original_title: String?
        let overview: String?
        let popularity: Float?
        let poster_path: String?
        let release_date: String?
        let title: String?
        let video: Bool?
        let vote_average: Float?
        let vote_count: Float?
    }
}

