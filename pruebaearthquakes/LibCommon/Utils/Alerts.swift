//
//  Alerts.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 22-11-23.
//

import Foundation
import UIKit

func AlertWithTittle(msg: String, title: String, controller: AnyObject){
    
    let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
    
    let titFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
    let msgFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
    
    let titAttrString = NSMutableAttributedString(string: title, attributes: titFont)
    let msgAttrString = NSMutableAttributedString(string: msg, attributes: msgFont)
    
    alert.setValue(titAttrString, forKey: "attributedTitle")
    alert.setValue(msgAttrString, forKey: "attributedMessage")
    
    let accion = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
    
    alert.addAction(accion)
    if (controller.view?.window != nil) {
        controller.present(alert, animated: true, completion: nil)
    }
}
