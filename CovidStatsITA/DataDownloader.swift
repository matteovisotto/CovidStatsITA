//
//  DataDownloader.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import Foundation
import UIKit

protocol DataDownloaderDelegate {
    func didDownload(result: Bool, data: [Dictionary<String, Any>])
}

class DataDownloader {
    private var downloadURL: String!
    open var delegate: DataDownloaderDelegate? = nil
    private let urlSession = URLSession.shared
    init(url: String) {
        downloadURL = url
    }
    
    func start() -> Void{
        let myURL = URL(string: self.downloadURL)!
        var myRequest = URLRequest(url: myURL)
        myRequest.allowsCellularAccess = true
        myRequest.setValue("keep-alive", forHTTPHeaderField: "Connection")
        
        let getTask = urlSession.dataTask(with: myRequest) { (data, response, error) in

            if (error != nil){
                
                    self.delegate?.didDownload(result: false, data: [])
                
            }
            let httpResponse = response as? HTTPURLResponse
            let statusCode = Int(httpResponse!.statusCode)
            
            if(statusCode == 200) {
                guard let data = data else { return }
                
                    let myData = self.dataToJSON(data: data)
                
                self.delegate?.didDownload(result: true, data: myData)
            } else {
                self.delegate?.didDownload(result: false, data: [])
                
            }
        }
            
        getTask.resume()
        
    }
    
    private func dataToJSON(data: Data) -> [Dictionary<String,Any>] {
        var decodedData: [Dictionary<String,Any>] = []
        let dataString = String(data: data, encoding: .isoLatin1)
        let data1 = dataString!.data(using: .utf8)!
        do {
            
            if let jsonArray = try JSONSerialization.jsonObject(with: data1, options : .allowFragments) as? [Dictionary<String,Any>]
            {
                decodedData=jsonArray
            } else if let jsonData = try JSONSerialization.jsonObject(with: data1, options: .allowFragments) as? Dictionary<String,Any> {
                decodedData.append(jsonData)
            } else {
                self.delegate?.didDownload(result: false, data: [])
            }
        } catch let error as NSError {
            print(error)
        }
        
        return decodedData
    }
}
