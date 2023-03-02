//
//  ProductDetailsViewController.swift
//  ApiFetch-Save
//
//  Created by Sejal on 02/03/23.
//

import UIKit
import SDWebImage

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

//        addBarButton()
        guard let productInfo = product else {
            return
        }
       
        labelTitle.text = productInfo.title
        labelBrand.text = productInfo.brand
        labelPrice.text = "\(productInfo.price)"
        labelDescription.text = productInfo.description
        let url = URL(string: productInfo.thumbnail)
        productImageView.sd_setImage(with: url)
    }
    
    @IBAction func addToWishlist(_ sender: Any) {
        addtoWishlist()
    }
    
//    func addBarButton(){
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Wishlist", style: .plain, target: nil, action: #selector(addtoWishlist))
//    }
    
    func addtoWishlist(){
        var dbhelper = DBHelper()
        if let selectedProduct = product {
            dbhelper.insert(product: selectedProduct)
        }
    }
    


}
