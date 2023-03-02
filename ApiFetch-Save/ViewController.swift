//
//  ViewController.swift
//  ApiFetch-Save
//  Created by Sejal on 02/03/23.
//

import UIKit

class ViewController: UIViewController {
    let productViewModel = ProductViewModel()
    
    @IBOutlet weak var productCollectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //productViewModel.fetchApi(url: "https://dummyjson.com/products", methodOfHttp: "GET")
       productViewModel.populateProducts()
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
    
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
       
        productCollectionView.reloadData()
    }

}

extension ViewController :  UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productViewModel.productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        let product = productViewModel.productArray[indexPath.row]
        cell.productLabel.text = product.brand
        cell.titleLabel.text = product.title
        cell.priceLabel.text = "\(product.price)"
        return cell
        
    }
    
}
