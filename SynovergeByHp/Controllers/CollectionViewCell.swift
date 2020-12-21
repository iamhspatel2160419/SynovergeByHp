//
//  CollectionViewCell.swift
//  SynovergeByHp
//
//  Created by Apple on 21/12/20.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var btnProduct: UIButton!
    
    func configCell(product:Product)
    {
        // get array from image path
        let fileArry = product.url!.components(separatedBy: "/")
        // get last file name from array & fetch Full Local Image URL
        let path = URL.urlInDocumentsDirectory(with: fileArry[fileArry.count-1]).path
        // loading image from Image URL
        let image = UIImage(contentsOfFile: path)
        self.imageView.image = image
        self.lblProductName.text = product.name
        self.lblProductQty.text = product.qty
    }
}

// custom collection view set up for cell height & row

class CustomImageLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns:CGFloat = 2.0
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize
    {
        set { }
        get {
            let itemWidth = (self.collectionView!.frame.width - (self.numberOfColumns - 1)) / self.numberOfColumns
            return CGSize(width: itemWidth, height: 378)
        }
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
}
