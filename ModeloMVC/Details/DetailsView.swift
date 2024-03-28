//
//  DetailsView.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 12/03/24.
//

import UIKit

class DetailsView: UIView {
    
        @IBOutlet private weak var starMaskView: StarMaskView!
        @IBOutlet private weak var imgMovie3: UIImageView!
        @IBOutlet private weak var lblName2: UILabel!
        @IBOutlet private weak var lblReleaseDate2: UILabel!
        @IBOutlet private weak var lblOverview: UILabel!
        @IBOutlet private weak var imgBackdrop: UIImageView!
        @IBOutlet private weak var lblGenres: UILabel!
        
    
    func dataInjection(fromModel model: Detail) {
         updateDataWith(model)
     }
    
        // Actualiza la UI con la información de la película
    func genreList(_ geners: [DetailsWS.GenreDTO]) -> String {
        var list = ""
        geners.forEach({gener in
            list += "\u{2022} \(gener.name ?? "")"
        })
        return list
    }
            func updateDataWith(_ detail: Detail) {
            let baseURLImage = "https://image.tmdb.org/t/p/w500"
            
            // Actualizar el póster de la película
            let posterURLImage = baseURLImage + detail.posterPath
            if let posterURL = URL(string: posterURLImage) {
                URLSession.shared.dataTask(with: posterURL) { (data, response, error) in
                    guard let imageData = data else { return }
                    DispatchQueue.main.async {
                        self.imgMovie3.image = UIImage(data: imageData)
                    }
                }.resume()
            }
            // Actualizar el fondo de la película
            let backdropURLImage = baseURLImage + detail.backdropPath
            if let backdropURL = URL(string: backdropURLImage) {
                URLSession.shared.dataTask(with: backdropURL) { (data, response, error) in
                    guard let imageData = data else { return }
                    DispatchQueue.main.async {
                        self.imgBackdrop.image = UIImage(data: imageData)
                        let blurEffect = UIBlurEffect(style: .dark)
                        let blurView = UIVisualEffectView(effect: blurEffect)
                        blurView.frame = self.imgBackdrop.bounds
                        self.imgBackdrop.addSubview(blurView)
                    }
                }.resume()
            }
                    
            self.lblName2.text = detail.originalTitle
            self.lblReleaseDate2.text = detail.releaseDate
            self.lblOverview.text = detail.overview
            self.starMaskView.setProgress(num: detail.vote_average)
            self.lblGenres.text = self.genreList(detail.genres)
        }
}


