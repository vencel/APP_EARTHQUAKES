//
//  DetailHomeViewController.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 23-11-23.
//

import Foundation
import UIKit
import MapKit

class DetailHomeViewController: BaseViewController, MKMapViewDelegate {
    
    var dataFeature: [Feature] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var magnitude: UILabel!
    @IBOutlet weak var depth: UILabel!
    @IBOutlet weak var place: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var zoomInButton: UIButton!
    @IBOutlet weak var zoomOutButton: UIButton!

    @IBAction func zoomInButtonTapped(_ sender: Any) {
        zoomMap(byFactor: 0.5)
    }
    

    @IBAction func zoomOutButtonTapped(_ sender: Any) {
        zoomMap(byFactor: 2.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideLoading()
        self.checkNetwork()
        self.disableTextBack(isEnable: false)
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hideLoading()
    }
    
    func loadData() {
        self.checkNetwork()

        titleLabel.text = dataFeature[0].properties.title
        magnitude.text = "Magnitud: \(String(describing: dataFeature[0].properties.mag!.description))"
        depth.text = "Profundidad: \(String(describing: dataFeature[0].geometry.coordinates[2].description))"
        place.text = "Lugar: \(String(describing: dataFeature[0].properties.place!))"
        
        loadMap()
    }
    
    func loadMap() {
        
        mapView.delegate = self
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        mapView.addGestureRecognizer(pinchGesture)
        
        let lat = dataFeature[0].geometry.coordinates[1]
        let lon = dataFeature[0].geometry.coordinates[0]
        
        // Configura la ubicación con latitud y longitud
        let location = CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(lon))

        // Configura la región para mostrar en el mapa
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)

        // Establece la región en el mapa
        mapView.setRegion(region, animated: true)

        // Agrega un marcador en la ubicación
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Ubicación"
        mapView.addAnnotation(annotation)
        
    }
    
    @objc func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .changed {
            let currentRegion = mapView.region
            let newRegion = MKCoordinateRegion(center: currentRegion.center,
                                               span: MKCoordinateSpan(latitudeDelta: currentRegion.span.latitudeDelta / Double(sender.scale),
                                                                    longitudeDelta: currentRegion.span.longitudeDelta / Double(sender.scale)))
            mapView.setRegion(newRegion, animated: false)
            sender.scale = 1.0
        }
    }
    

    func zoomMap(byFactor factor: Double) {
        let currentRegion = mapView.region
        let newRegion = MKCoordinateRegion(center: currentRegion.center,
                                           span: MKCoordinateSpan(latitudeDelta: currentRegion.span.latitudeDelta * factor,
                                                                longitudeDelta: currentRegion.span.longitudeDelta * factor))
        mapView.setRegion(newRegion, animated: true)
    }

}
