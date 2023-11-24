//
//  HomeViewCell.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 23-11-23.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var magnitude: UILabel!
    @IBOutlet weak var depth: UILabel!
    @IBOutlet weak var place: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Configuración de la celda personalizada
//        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Configuración de la celda personalizada
//        setupUI()
    }

    private func setupUI() {
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.containerView.layer.shadowOpacity = 0.16
        self.containerView.layer.shadowRadius = 4.0
        self.containerView.layer.cornerRadius = 20
    }
    
    func setList(item: Feature) {
        setupUI()
        
        titleLabel.text = item.properties.title
        magnitude.text = "Magnitud: \(String(describing: item.properties.mag!.description))"
        depth.text = "Profundidad: \(String(describing: item.geometry.coordinates[2].description))"
        place.text = "Lugar: \(String(describing: item.properties.place!))"
        
    }

}
