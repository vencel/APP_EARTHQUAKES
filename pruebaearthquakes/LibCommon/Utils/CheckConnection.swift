//
//  CheckConnection.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 22-11-23.
//

import SystemConfiguration
import Connectivity

public class CheckConnection{
    
    static let con = Connectivity()
    
    class func startCheckConnection(){
        con.connectivityURLs = [URL(string: GenericTexts.urlConnectivityApple)!]
        con.isPollingEnabled = true
        con.checkConnectivity()
        con.pollingInterval = 1
        con.connectivityCheckLatency = 0
        con.framework = .network
        con.startNotifier()
    }
    class func stopCheckConnection(){
        con.stopNotifier()
    }
    class func Connection() -> Bool{
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false{
            return false
        }
        
        //Working for cellular and Wifi
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        // retornar si está conectado a wifi sin internet
        //con.checkConnectivity()
        //self.con.framework = .network
        let flag:Bool =  con.isConnectedViaCellularWithoutInternet || con.isConnectedViaWiFiWithoutInternet
        print(flag)
        return ret && !flag
    }
    
    class func testConnection(_ completion: @escaping ()->()){
        AppDelegate().conector.con.checkConnectivity(completion: { con2 in
            if con2.isConnected && !con2.isConnectedViaCellularWithoutInternet && !con2.isConnectedViaWiFiWithoutInternet {
                completion()
            } else {
                AlertWithTittle(msg: Messages.ErrorSinInternetGenerico.rawValue, title: GenericTexts.TitleUps, controller: LoginViewController())
            }
        })
    }
    
    class func isNetworkReachable() -> Bool{
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.raywenderlich.com")
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        let isRecheable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        
        return isRecheable && (!needsConnection || canConnectAutomatically)
    }
    
    class func checkInternet(showLoader: Bool = true, completionHandler:@escaping (_ internet:Bool) -> Void) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url = URL(string: GenericTexts.urlGoogle)
        var req = URLRequest.init(url: url!)
        req.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        req.timeoutInterval = 10.0
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            if error != nil  {
                completionHandler(false)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completionHandler(true)
                    } else {
                        completionHandler(false)
                    }
                } else {
                    completionHandler(false)
                }
            }
        }
        task.resume()
    }
}



