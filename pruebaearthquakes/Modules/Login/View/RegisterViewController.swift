//
//  RegisterViewController.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 24-11-23.
//

import Foundation
import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    @IBOutlet weak var claveTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideLoading()
        self.checkNetwork()
        self.disableTextBack(isEnable: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hideLoading()
    }
    
    @IBAction func registrarButtonTapped(_ sender: UIButton) {
        do {
            guard let email = emailTextField.text,
                  let nombre = nombreTextField.text,
                  let apellido = apellidoTextField.text,
                  let clave = claveTextField.text else {
                throw RegistroError.datosIncompletos
            }

            let nuevoUsuario = UsuarioRegistro(email: email, nombre: nombre, apellido: apellido, clave: clave)
            AutenticacionManager.registrar(usuario: nuevoUsuario)

            // Registro exitoso, realiza acciones adicionales según sea necesario
            errorLabel.text = "Registro exitoso. Usuario registrado: \(nuevoUsuario.email)"
        } catch RegistroError.datosIncompletos {
            errorLabel.text = "Todos los campos son obligatorios."
        } catch {
            errorLabel.text = "Error desconocido al registrar usuario."
        }
    }
}

enum RegistroError: Error {
    case datosIncompletos
}
