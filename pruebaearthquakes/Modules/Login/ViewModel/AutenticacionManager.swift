//
//  UserAutenticate.swift
//  aerthquakes
//
//  Created by Manuel Venegas Celis on 21-11-23.
//


// Clase para representar un usuario
class Usuario {
    var email: String
    var clave: String
    
    init(email: String, clave: String) {
        self.email = email
        self.clave = clave
    }
}

import KeychainSwift

// Clase para manejar la autenticación
class AutenticacionManager {
    
    private static let keychain = KeychainSwift()
    
    static var usuarios: [Usuario] = [
        Usuario(email: "admin@prueba.com", clave: "1234")
    ]
    
    static var usuarioActual: Usuario?
    
    static func login(email: String, clave: String) throws -> Usuario {
        guard let usuario = usuarios.first(where: { $0.email == email && $0.clave == clave }) else {
            throw ErrorAutenticacion.usuarioNoEncontrado
        }
        usuarioActual = usuario
        return usuario
    }
    
    static func registrar(usuario: UsuarioRegistro) {
            let nuevoUsuario = Usuario(email: usuario.email, clave: usuario.clave)
            usuarios.append(nuevoUsuario)

            // Almacena el email en Keychain para futuras consultas
            keychain.set(usuario.email, forKey: "usuarioRegistrado")
        }

        static func obtenerUsuarioRegistrado() -> String? {
            // Obtiene el email almacenado en Keychain
            return keychain.get("usuarioRegistrado")
        }
    
    static func logout() {
            usuarioActual = nil
        }
}

// Enum para manejar errores de autenticación
enum ErrorAutenticacion: Error {
    case usuarioNoEncontrado
}

