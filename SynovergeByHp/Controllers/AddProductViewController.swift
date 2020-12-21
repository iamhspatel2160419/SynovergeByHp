//
//  AddProductViewController.swift
//  SynovergeByHp
//
//  Created by Apple on 21/12/20.
//

import UIKit
import Photos

class AddProductViewController: UIViewController {

    fileprivate var vm = AddProductViewModel()
    
    var imagePicker: ImagePicker!
    
    @IBOutlet weak var imgViewProduct: UIImageView!
    @IBOutlet weak var txtFieldProductQty: UITextField!
    @IBOutlet weak var txtFieldProductName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgViewProduct.isUserInteractionEnabled = true
        imgViewProduct.addGestureRecognizer(tapGestureRecognizer)

        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // Requesting Image Photo library permissions
        PHPhotoLibrary.requestAuthorization { [weak self] (status)  in
            if status == .authorized
            {
                if let view = tapGestureRecognizer.view
                {
                    DispatchQueue.main.async
                    {
                        self?.imagePicker.present(from: view)
                    }
                }
            }
            else
            {
                DispatchQueue.main.async
                {
                    // Go to settings Page for Permission Request
                    self?.vm.openSettingDirectory()
                }
                
            }
        }
        
    }
   
    
    @IBAction func btnSaveProductInfo(_ sender: UIButton)
    {
        let productName = self.txtFieldProductName.text
        let productQty = self.txtFieldProductQty.text
        self.vm.productName = productName
        self.vm.productQty = productQty
      
        // validating fields
        if(self.vm.validate().0)
        {
            // save products to database
            vm.saveProduct
            { isSuccess in
                if isSuccess == true
                {
                    DispatchQueue.main.async
                    {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                else
                {
                    Helper.sharedHelper.showAlert("Error !",
                                                  alertMessage: "Product save operation failed")
                    return
                }
            }
        }
        else
        {
            DispatchQueue.main.async
            {
                Helper.sharedHelper.showAlert("Error !", alertMessage: self.vm.validate().1)
            }
            
        }
    }
}
extension AddProductViewController: ImagePickerDelegate
{
    // Image Picker view delegate method give image Data of UIImage type & setting to UIImageView
    func didSelect(image: UIImage?) {
        self.imgViewProduct.image = image
        if let image = self.imgViewProduct.image
        {
            // save image to documents directory locally
            let strImagePathUrl = (Helper.sharedHelper.saveimageToDocumentDirectory(image))
            _ = strImagePathUrl.components(separatedBy: "/")
            
            // setting url to viewModel
            self.vm.productImageUrl = strImagePathUrl
        }
    }
}
