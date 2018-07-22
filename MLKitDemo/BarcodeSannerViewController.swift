//
//  BarcodeSannerViewController.swift
//  MLKitDemo
//
//  Created by Anoop tomar on 7/20/18.
//  Copyright © 2018 Devtechie. All rights reserved.
//

import UIKit
import Firebase

class BarcodeSannerViewController: UIViewController {
    
    var sourceImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textV: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = sourceImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.decodeBarcode()
    }
    
    func decodeBarcode() {
        let options = VisionBarcodeDetectorOptions(formats: VisionBarcodeFormat.all)
        let vision = Vision.vision()
        
        let barcodeDetector = vision.barcodeDetector(options: options)
        let image = VisionImage(image: sourceImage!)
        barcodeDetector.detect(in: image) { [weak self] (barcodes, error) in
            guard error == nil, let barcodes = barcodes, !barcodes.isEmpty else {
                print("error decoding")
                return
            }
            
            for barcode in barcodes {
                let rawValue = barcode.rawValue!
                self?.textV.text = (self?.textV.text)! + " " + rawValue
            }
        }
    }
}











