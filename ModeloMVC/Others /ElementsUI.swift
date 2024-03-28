//
//  ElementsUI.swift
//  ModeloMVC
//
//  Created by Juan Felipe Acevedo Ramirez on 14/03/24.
//

import UIKit

class StarMaskView: UIView {
    let size: Int
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .orange
        progressView.trackTintColor = UIColor(white: 0, alpha: 0)
        return progressView
    }()
    
    init(size: Int) {
        self.size = size
        super.init(frame: .init(x: 0, y: 0, width: size, height: 18))
        translatesAutoresizingMaskIntoConstraints = false
        setupMask()
        setupProgressView()
    }
    
    required init?(coder: NSCoder) {
        self.size = 10
        super.init(coder: coder)
        setupMask()
        setupProgressView()
    }
    
    private func setupProgressView() {
        addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setProgress(num: Float) {
        self.progressView.progress = num / Float(size)
    }
    
    private func setupMask() {
        // Tamaño de cada estrella
        let starWidth = bounds.width / CGFloat(size)
        let starHeight = bounds.height
        let scale: CGFloat = 0.9 // Ajusta este valor para cambiar el tamaño de las estrellas
        let scaledStarWidth = starWidth * scale
        let scaledStarHeight = starHeight * scale
        
        // Crear la capa de máscara
        let maskLayer = CAShapeLayer()
        
        // Posicionar cada estrella en fila
        for i in 0..<size {
            let xOffset = CGFloat(i) * starWidth + (starWidth - scaledStarWidth) / 2
            let yOffset = (starHeight - scaledStarHeight) / 2
            // Crear la forma de cada estrella
            let starPath = UIBezierPath()
            starPath.move(to: CGPoint(x: xOffset + 0.5 * scaledStarWidth, y: yOffset))
            starPath.addLine(to: CGPoint(x: xOffset + 0.65 * scaledStarWidth, y: yOffset + 0.35 * scaledStarHeight))
            starPath.addLine(to: CGPoint(x: xOffset + scaledStarWidth, y: yOffset + 0.4 * scaledStarHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.75 * scaledStarWidth, y: yOffset + 0.65 * scaledStarHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.8 * scaledStarWidth, y: yOffset + scaledStarHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.5 * scaledStarWidth, y: yOffset + 0.85 * scaledStarHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.2 * scaledStarWidth, y: yOffset + scaledStarHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.25 * scaledStarWidth, y: yOffset + 0.65 * scaledStarHeight))
            starPath.addLine(to: CGPoint(x: xOffset, y: yOffset + 0.4 * scaledStarHeight))
            starPath.addLine(to: CGPoint(x: xOffset + 0.35 * scaledStarWidth, y: yOffset + 0.35 * scaledStarHeight))
            starPath.close()
            
            // Crear una capa de forma y asignar la forma de la estrella
            let starMaskLayer = CAShapeLayer()
            starMaskLayer.path = starPath.cgPath
            starMaskLayer.fillColor = UIColor.orange.cgColor // Color del fondo
            maskLayer.addSublayer(starMaskLayer)
        }
        
        // Asignar la capa de máscara a la vista
        layer.mask = maskLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Asegúrate de que 'setupMask()' se llama cuando las dimensiones de la vista están establecidas
        setupMask()
    }
}
