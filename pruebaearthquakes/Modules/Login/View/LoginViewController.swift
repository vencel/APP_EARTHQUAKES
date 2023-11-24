//
//  LoginViewController.swift
//  aerthquakes
//
//  Created by Manuel Venegas Celis on 21-11-23.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Configuraciones adicionales si es necesario
        self.disableTextBack()
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        do {
            guard let email = emailTextField.text, let password = passwordTextField.text else {
                throw ErrorAutenticacion.usuarioNoEncontrado
            }

            let usuario = try AutenticacionManager.login(email: email, clave: password)
            // Login exitoso, realiza acciones adicionales según sea necesario

            self.checkNetwork()
            
            self.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.hideLoading()
                let controller = HomeViewController().instantiateViewController() as! HomeViewController
                self.navigateToControllerInStoryboard(controller: controller,isFullScreen: true)
                
            }
        } catch {
            errorLabel.text = Messages.ErrorUsuarioNoEncontrado.rawValue
        }
    }
    
    @IBAction func RegisterButtonTapped(_ sender: UIButton) {
        self.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hideLoading()
            let controller = RegisterViewController().instantiateViewController() as! RegisterViewController
            self.navigateToControllerInStoryboard(controller: controller,isFullScreen: true)
            
        }
    }
}

