//
//  ViewController.swift
//  MLKitDemo
//
//  Created by Anoop tomar on 7/13/18.
//  Copyright © 2018 Devtechie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let kTextRecog = "textRecog"
    let kFaceDetect = "faceDetect"
    let kImageLabelling = "imageLabelling"
    let kBarcodeDetect = "barcodeDetect"
    
    @IBOutlet weak var imageV: UIImageView!
    
    lazy var imagePicker: UIImagePickerController = {
        return UIImagePickerController()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }

    //MARK: choose button action
    @IBAction func didTapChooseImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        // present image picker controller
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: image picker controller delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageV.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: segue actions
    @IBAction func didTapTextRecog(_ sender: UIButton) {
        performSegue(withIdentifier: kTextRecog, sender: self)
    }
    
    @IBAction func didTapFaceDetect(_ sender: UIButton) {
        performSegue(withIdentifier: kFaceDetect, sender: self)
    }
    
    @IBAction func didTapImageLabelling(_ sender: UIButton) {
        performSegue(withIdentifier: kImageLabelling, sender: self)
    }
    
    @IBAction func didTapBarcodeDetect(_ sender: UIButton) {
        performSegue(withIdentifier: kBarcodeDetect, sender: self)
    }
    
    //MARK: perpare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kTextRecog {
            let vc = segue.destination as! TextRecogViewController
            vc.sourceImage = self.imageV.image
        } else if segue.identifier == kFaceDetect {
            let vc = segue.destination as! FaceDetectViewController
            vc.sourceImage = self.imageV.image
        } else if segue.identifier == kBarcodeDetect {
            let vc = segue.destination as! BarcodeSannerViewController
            vc.sourceImage = self.imageV.image
        } else if segue.identifier == kImageLabelling {
            let vc = segue.destination as! ImageLabelViewController
            vc.sourceImage = self.imageV.image
        }
    }
}
















