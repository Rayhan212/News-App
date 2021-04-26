//
//  NewsApi.swift
//  weather
//
//  Created by han on 05/02/21.
//

//pengirim = ObservableObject
//penerima = ObserveObject

import Foundation
import Combine
import SwiftyJSON

class NewsApi: ObservableObject {
    @Published var data = [News]()
    init() {
        let url = "http://newsapi.org/v2/top-headlines?country=id&category=science&apiKey=48bb87e423a84ab682400895c50c7d78"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){(data, _ ,err)in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            let json = try! JSON(data: data!)
            let items = json["articles"].array!
            
            for i in items{
                let title = i["title"].stringValue
                let description = i["description"].stringValue
                let imurl = i["urlToImage"].stringValue
                
                DispatchQueue.main.async {
                    self.data.append(News(title: title, image: imurl, description: description))
                }
            }
        }.resume()
    }
}

