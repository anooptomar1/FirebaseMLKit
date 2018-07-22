//
//  FaceDetectViewController.swift
//  MLKitDemo
//
//  Created by Anoop tomar on 7/19/18.
//  Copyright © 2018 Devtechie. All rights reserved.
//

import UIKit
import Firebase

class FaceDetectViewController: UIViewController {
    
    var sourceImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textV: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = sourceImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.detectFaces()
    }
    
    func detectFaces() {
        let vision = Vision.vision()
        let options = VisionFaceDetectorOptions()
        options.modeType = .accurate
        options.landmarkType = .all
        options.classificationType = .all
        options.minFaceSize = CGFloat(0.1)
        options.isTrackingEnabled = true
        
        let faceDetector = vision.faceDetector(options: options)
        let visionImage = VisionImage(image: sourceImage!)
        faceDetector.detect(in: visionImage) {[weak self] (faces, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let faces = faces else {return}
            var image = self?.imageView.image!
            
            var count = 1
            var message = ""
            faces.forEach({ (face) in
                image = self?.drawRectOnImage(image: image!, cgrect: face.frame)
                if face.hasLeftEyeOpenProbability {
                    if face.leftEyeOpenProbability > 0.4 {
                        message += "Person\(count)'s left eye is open.\n"
                    } else {
                        message += "Person\(count)'s left eye is closed.\n"
                    }
                }
                if face.hasRightEyeOpenProbability {
                    if face.rightEyeOpenProbability > 0.4 {
                        message += "Person\(count)'s right eye is open.\n"
                    } else {
                        message += "Person\(count)'s right eye is closed.\n"
                    }
                }
                if face.hasSmilingProbability {
                    if face.smilingProbability > 0.5 {
                        message += "Person\(count) is smiling.\n"
                    } else {
                        message += "Person\(count) is not smiling.\n"
                    }
                }
                count += 1
            })
            self?.imageView.image = image
            self?.textV.text = message
        }
    }
    
    func drawRectOnImage(image: UIImage, cgrect: CGRect) -> UIImage {
        let imageSize = image.size
        let scale:CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        let context = UIGraphicsGetCurrentContext()
        image.draw(at: CGPoint.zero)
        context?.saveGState()
        context?.setStrokeColor(UIColor.green.cgColor)
        context?.setLineWidth(2.0)
        context?.addRect(cgrect)
        context?.drawPath(using: .stroke)
        context?.restoreGState()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
