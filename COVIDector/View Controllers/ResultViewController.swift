//
//  ResultViewController.swift
//  COVIDector
//
//  Created by Kapil on 29/03/21.
//

import UIKit
import CoreML
import Vision

class ResultViewController: UIViewController {
    
    var testingImage = UIImage()
    var testImage = UIImage(named: "Negative Sample.jpg")
    var testImageTwo = UIImage(named: "Positive Sample.jpeg")
    var resultsLabel = UILabel()
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            // 1
            let healthySnacks = try COVIDNetV2(configuration: MLModelConfiguration())
            // 2
            let visionModel = try VNCoreMLModel(
                for: healthySnacks.model)
            // 3
            let request = VNCoreMLRequest(model: visionModel,
                                          completionHandler: {
                                            [weak self] request, error in
                                            //  print("Request is finished!", request.results as Any)
                                            self?.processObservations(for: request, error: error)
                                          })
            // 4
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to create VNCoreMLModel: \(error)")
        }
    }()
    
    func classify(image: UIImage) {
        // 1
        guard let ciImage = CIImage(image: image) else {
            print("Unable to create CIImage")
            return
        }
        // 2
        let orientation = CGImagePropertyOrientation(
            rawValue: UInt32(image.imageOrientation.rawValue))!
        // 3
        DispatchQueue.global(qos: .userInitiated).async {
            // 4
            let handler = VNImageRequestHandler(
                ciImage: ciImage,
                orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification: \(error)")
            }
        }
    }
    
    func processObservations(
        for request: VNRequest,
        error: Error?) {
        // 1
        DispatchQueue.main.async {
            // 2
            if let results = request.results
                as? [VNClassificationObservation] {
                // 3
                if results.isEmpty {
                    self.resultsLabel.text = "nothing found"
                } else {
                    self.resultsLabel.text = String(
                        format: "%@ %.1f%%",
                        results[0].identifier,
                        results[0].confidence * 100)
                }
                // 4
            } else if let error = error {
                self.resultsLabel.text =
                    "error: \(error.localizedDescription)"
            } else {
                self.resultsLabel.text = "???"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsLabel.text = "Result"
        resultsLabel.textAlignment = .center
        resultsLabel.textColor = .black
        resultsLabel.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: DeviceSize.deviceHeight * 0.2, width: DeviceSize.deviceWidth * 0.9, height: resultsLabel.intrinsicContentSize.height)
        self.view.addSubview(resultsLabel)
        
        classify(image: testingImage)
        
    }
    
}
