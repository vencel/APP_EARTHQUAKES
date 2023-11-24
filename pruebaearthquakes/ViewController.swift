//
//  ViewController.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 21-11-23.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = SplashViewController().instantiateViewController() as! SplashViewController
        self.navigateToControllerInStoryboard(controller: controller,isFullScreen: true)
    }

}

