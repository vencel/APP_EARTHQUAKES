//
//  SplashViewController.swift
//  aerthquakes
//
//  Created by Manuel Venegas Celis on 21-11-23.
//

import UIKit

class SplashViewController: BaseViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableTextBack()
        
        // Configuración del activityIndicator
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)

        // Comienza la animación
        activityIndicator.startAnimating()

        // Simula un trabajo en segundo plano más prolongado
        DispatchQueue.global(qos: .background).async {
            // Simula un trabajo que lleva más tiempo (10 segundos en este ejemplo)
            Thread.sleep(forTimeInterval: 10)

//            DispatchQueue.main.async {
//                // Detén la animación en el hilo principal después de que el trabajo en segundo plano haya terminado
//                self.activityIndicator.stopAnimating()
//            }
        }
        
        // Programa la transición después de 3 segundos
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.mostrarLoginViewController()
        }
    }

    func mostrarLoginViewController() {
        DispatchQueue.main.async {
            let controller = LoginViewController().instantiateViewController() as! LoginViewController
//            let controller = HomeViewController().instantiateViewController() as! HomeViewController
            self.navigateToControllerInStoryboard(controller: controller,isFullScreen: true)
            self.activityIndicator.stopAnimating()
        }
    }

}

