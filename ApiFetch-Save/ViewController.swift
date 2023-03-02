//
//  ViewController.swift
//  ApiFetch-Save
//  Created by Sejal on 02/03/23.
//

import UIKit

class ViewController: UIViewController {
    let productViewModel = ProductViewModel()
    
    @IBOutlet weak var productCollectionView: UICollectionView!
   
    @IBAction func switchDataSource(_ sender: UISwitch) {
        if sender.isOn {
            productViewModel.getProductsFromDb()
        } else {
            productViewModel.fetchApi(url: "https://dummyjson.com/products", methodOfHttp: "GET")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productViewModel.protocolProductData = self  // link with sender
        
        productViewModel.getProductsFromDb()
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
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item selected at row \(indexPath.row)")

        let productDetailsViewController = (self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController)!

        productDetailsViewController.product = productViewModel.productArray[indexPath.row]
        self.navigationController?.pushViewController(productDetailsViewController, animated: true)
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
