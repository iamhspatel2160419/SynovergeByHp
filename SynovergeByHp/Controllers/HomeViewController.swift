//
//  HomeViewController.swift
//  SynovergeByHp
//
//  Created by Apple on 21/12/20.
//

import UIKit

class HomeViewController: UIViewController,
                          UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout{

    private var vm:ProductListViewModel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = CustomImageLayout()
        vm = ProductListViewModel()
        // fetching data from Database.
        vm.fetchData(){ isDone in
            if isDone == true
            {
                self.reloadData(isInvalidate:true)
            }
            else
            {
                DispatchQueue.main.async
                {
                    Helper.sharedHelper.showAlert("Oops !",
                                                  alertMessage: "No product found. \n Add new product.")
                }
            }
        }
    
    }
    
    // MARK: Collection View SetUp
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.productList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configCell(product:vm.productList[indexPath.row])
        
        cell.btnProduct.tag = indexPath.row
        cell.btnProduct.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
        
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
           let width = collectionView.frame.width
           return CGSize(width: width/2 - 1, height: 378)
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    // MARK: refresh Collection View
    func reloadData(isInvalidate:Bool=false)
    {
        DispatchQueue.main.async
        {
            if isInvalidate == true
            {
                self.collectionView.collectionViewLayout.invalidateLayout()
            }
            self.collectionView.reloadData()
        }
    }
    
    // MARK: delete product
    @objc func didButtonClick(_ sender: UIButton)
    {
        let index = sender.tag
        let product = vm.productList[index]
        if let product_id_ = product.product_id
        {   vm.deleteProductAt(index,product_id:product_id_){
                isDone , list  in
                if isDone {
                    self.vm.productList.removeAll()
                    self.vm.productList = list
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.reloadData(isInvalidate:true)
                    }
                }
            }
        }
        
    }
}


