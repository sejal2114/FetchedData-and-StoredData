//
//  UsersModelView.swift
//  ApiFetch-Save
//
//  Created by Sejal on 02/03/23.
//

import Foundation
import SQLite3
class ProductViewModel {
    var productArray: [Product] = []
    
    func populateProducts(){
        let product1 = Product(id: 1, title: "sej", description: "gsh", price: 12, discountPercentage: 12.1, rating: 12.2, stock: 11, brand: "mac", thumbnail: "sejalal")
        let product2 = Product(id: 2, title: "jkdj", description: "dd", price: 22, discountPercentage: 12.1, rating: 12.8, stock: 13, brand: "mac", thumbnail: "sejalal")
        let product3 = Product(id: 3, title: "sehhj", description: "gsh", price: 12, discountPercentage: 12.1, rating: 12.2, stock: 11, brand: "mac", thumbnail: "sejalal")
        productArray.append(product1)
        productArray.append(product2)
        productArray.append(product3)
        print(productArray)
    }

    func fetchApi(url:String, methodOfHttp:String){
        //Create a URL object
        guard let url = URL(string: url) else {
            return
        }
        // create a URLRequest object and pass it to the dataTask(with:) method.
        var request = URLRequest(url: url)
        request.httpMethod = methodOfHttp
        //create object of urlsession
        let urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            guard let responseData = data else {
              print("Data Nil")
              return
            }
            print(String(data: responseData, encoding: .utf8)!)
            
        }
        dataTask.resume()
    }
}
