//
//  TextRecogViewController.swift
//  MLKitDemo
//
//  Created by Anoop tomar on 7/17/18.
//  Copyright © 2018 Devtechie. All rights reserved.
//

import UIKit
import Firebase

class TextRecogViewController: UIViewController {
    
    var sourceImage: UIImage?
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var textV: UITextView!
    
    //MARK: Firebase var
    lazy var vision = Vision.vision()
    var textDetector: VisionTextDetector?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageV.image = sourceImage
        self.textV.text = ""
        
        textDetector = vision.textDetector()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let image = VisionImage(image: sourceImage!)
        textDetector?.detect(in: image, completion: { (features, error) in
            guard error == nil, let features = features, !features.isEmpty else {
                print(error!.localizedDescription)
                return
            }
            
            print("detected text has \(features.count) blocks.")
            
            for feature in features {
                let text = feature.text
                self.textV.text = self.textV.text + " " + text
            }
        })
    }
}








