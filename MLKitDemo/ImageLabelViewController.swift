//
//  ImageLabelViewController.swift
//  MLKitDemo
//
//  Created by Anoop tomar on 7/20/18.
//  Copyright © 2018 Devtechie. All rights reserved.
//

import UIKit
import Firebase

class ImageLabelViewController: UIViewController {
    
    var sourceImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textV: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = sourceImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // image labeling using MLKit
        let vision = Vision.vision()
        let labelDetector = vision.labelDetector()
        let visionImage = VisionImage(image: sourceImage!)
        
        labelDetector.detect(in: visionImage) { [weak self] (labels, error) in
            
            guard error == nil, let labels = labels, !labels.isEmpty else {
                print("labeling error")
                return
            }
            
            for label in labels {
                self?.textV.text = (self?.textV.text)! + "\n" + "\(label.label) - \(label.confidence * 100.0)%"
            }
            
        }
    }
   
}
















