//
//  RegisterModel.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 24-11-23.
//

import Foundation

class UsuarioRegistro {
    var email: String
    var nombre: String
    var apellido: String
    var clave: String
    
    init(email: String, nombre: String, apellido: String, clave: String) {
        self.email = email
        self.nombre = nombre
        self.apellido = apellido
        self.clave = clave
    }
}
