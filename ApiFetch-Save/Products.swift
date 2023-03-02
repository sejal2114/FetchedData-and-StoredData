//
//  Users.swift
//  ApiFetch-Save
//
//  Created by Sejal on 02/03/23.
//

import Foundation
struct Roots:Decodable {
    var products: [Product]
    
}
struct Product:Decodable {
    var id: Int
    var title: String
    var description: String
    var price: Int
    var discountPercentage:Float64
    var rating: Double
    var stock: Int
    var brand: String
    var thumbnail: String
}
        
     
