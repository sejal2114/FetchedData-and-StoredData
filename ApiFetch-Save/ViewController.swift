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
        productViewModel.protocolProductData = self  // link with sender
        
        productViewModel.fetchApi(url: "https://dummyjson.com/products", methodOfHttp: "GET")
      // productViewModel.populateProducts()
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
    
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }

}

extension ViewController :  UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
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
  
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height * 0.25
        let width = view.frame.size.width * 0.30
        return CGSize(width: width, height: height)
    }
    
    
}

extension ViewController: ProtocolProductData {
    func reloadView() {
            DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
}
