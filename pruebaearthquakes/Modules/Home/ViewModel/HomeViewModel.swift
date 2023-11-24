//
//  HomeViewModel.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 23-11-23.
//

import Foundation
import RxSwift
import RxRelay

struct HomeViewModel {
    
    func getListEarthQuakes(view: UIViewController, completion: @escaping (_ index: Any) -> Void) {
        
        let urlBase = apiService.getListEarthQuakes
        
        let response = sendRequest(url: urlBase.url, httpMethod: urlBase.method, contentType: urlBase.contentType, jsonString: nil)
  
        DispatchQueue.main.async {
            do {
                if let data = response.data {
                    //print("DATA SIMULATION : \(String(decoding: data, as: UTF8.self))")
                    let decoder = JSONDecoder()
                    let dataResponse = try decoder.decode(HomeResponse.self, from: data)
                    completion(dataResponse)
                }else{
                    completion("")
                }
            } catch let error {
                completion(error)
                print(error)
                return
            }
        }
    }
    
}
