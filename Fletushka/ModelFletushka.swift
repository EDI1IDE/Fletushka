//
//  modelFletushka.swift
//  Fletushka
//
//  Created by Muhamed Zahiri on 05.02.22.
//

import Foundation
import Alamofire

class ModelFletushka: Codable{
    var url: String
    var featured: Bool
    var order: Order
    var name, date: String

    init(url: String, featured: Bool, order: Order, name: String, date: String) {
        self.url = url
        self.featured = featured
        self.order = order
        self.name = name
        self.date = date
    }
    
}

enum Order: String, Codable {
    case bottom = "bottom"
    case mid = "mid"
    case top = "top"
}

typealias Fletushka = [ModelFletushka]



