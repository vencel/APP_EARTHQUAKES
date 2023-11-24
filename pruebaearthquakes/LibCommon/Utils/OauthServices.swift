//
//  OauthServices.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 23-11-23.
//

import Foundation
import Alamofire


public func sendRequest(url: String, httpMethod: requestType, contentType: contentType, jsonString: String?) -> requestResponse{
    
    let semaphore = DispatchSemaphore(value: 0)
    var result = requestResponse()
    
    
    guard let Url = URL(string: url) else { return result }
    var request = URLRequest(url: Url)
    
    request.httpMethod = httpMethod.rawValue
    request.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
    
    
    if let jsonString = jsonString {
        request.httpBody = jsonString.data(using: String.Encoding.utf8)
    }
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            print("url: \(url) - CODE: \(httpStatus.statusCode)")
            print("DATA \(String(decoding: data!, as: UTF8.self))")
            
            if (httpStatus.statusCode > 400 && httpStatus.statusCode < 403){
                
                    result = sendRequest(url: url, httpMethod: httpMethod, contentType: contentType, jsonString: jsonString)
            }
           
            semaphore.signal()
            return
            
        }
        
        guard error == nil else {
            print("url: \(url) - error")
            semaphore.signal()
            result.ErrorMessage = Messages.ErrorGenerico.rawValue
            return
        }
        
        guard let data = data else {
            semaphore.signal()
            result.ErrorMessage = Messages.ErrorGenerico.rawValue
            return
        }
        
        result.data = data
        
        semaphore.signal()
        
    })
    task.resume()
    
    semaphore.wait()
    
    return result
}


public enum requestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public struct requestResponse {
    var data: Data?
    var ErrorMessage: String = Messages.ErrorGenerico.rawValue
}
