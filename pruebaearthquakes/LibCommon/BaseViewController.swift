//
//  BaseViewController.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 22-11-23.
//

import SafariServices
import UIKit

class BaseViewController: UIViewController {
    
    var validateNetwork = true
    
    private var sideMenuViewController: SideMenuViewController!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    // Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!

    private var revealSideMenuOnTop: Bool = true
    
    var gestureEnabled: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.disableTextBack()
        self.checkNetwork()
    }
    
    func navigateToControllerInStoryboard(
        controller: UIViewController,
        isFullScreen:Bool = true) {
            
            guard self.navigationController != nil else {
                return
            }
            if isFullScreen {
                controller.modalPresentationStyle = .fullScreen
            }
            self.navigationController?.pushViewController(controller, animated: true)
        }
    
    func disableTextBack(isEnable: Bool = true) {
        if isEnable {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back_button"), style: .plain, target: self, action: #selector(self.back(sender:)))
            self.navigationItem.leftBarButtonItem!.imageInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
            
            self.navigationItem.leftBarButtonItem!.tintColor = UIColor.white
//            self.tabBarController?.tabBar.tintColor = UIColor.lightGray
        }
    }
    
    @objc func back(sender: AnyObject) {
        if !CheckConnection.Connection() && validateNetwork {
            AlertWithTittle(msg: Messages.ErrorSinInternetGenerico.rawValue, title: GenericTexts.TitleUps, controller: self)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func checkNetwork() {
        if !CheckConnection.Connection() {
            AlertWithTittle(msg: Messages.ErrorSinInternetGenerico.rawValue, title: GenericTexts.TitleUps, controller: self)
        }
    }
    
    func showLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tag = 999 // Identificador para poder encontrar el indicador más tarde
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        if let activityIndicator = view.viewWithTag(999) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
//    func showMenu() {
//        // Shadow Background View
//        self.sideMenuShadowView = UIView(frame: self.view.bounds)
//        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.sideMenuShadowView.backgroundColor = .black
//        self.sideMenuShadowView.alpha = 0.0
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
//        tapGestureRecognizer.numberOfTapsRequired = 1
//        tapGestureRecognizer.delegate = self
//        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
//        if self.revealSideMenuOnTop {
//            view.insertSubview(self.sideMenuShadowView, at: 1)
//        }
//    }
    
}

