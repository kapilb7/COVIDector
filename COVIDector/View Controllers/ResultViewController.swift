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
    var titleLabel = UILabel()
    var resultsLabel = UILabel()
    var results = UILabel()
    var classLabel = ""
    var classProb = Float(0.0)
    
    let resultsFontSize = 32 * (DeviceSize.deviceHeight / DeviceSize.baseHeight)
    let labelFontSize = 24 * (DeviceSize.deviceHeight / DeviceSize.baseHeight)

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
                    self.classLabel = results[0].identifier
                    self.classProb = results[0].confidence * 100
                    
                   // self.results.numberOfLines = 0
                    let attr1 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.labelFontSize), NSAttributedString.Key.foregroundColor : UIColor.systemGray]
                    let attr2 = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: self.resultsFontSize), NSAttributedString.Key.foregroundColor : UIColor.systemGreen]
                    let attr3 = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: self.resultsFontSize), NSAttributedString.Key.foregroundColor : UIColor.systemRed]
                    
                    let partOne = NSMutableAttributedString(string: "Based on the Input data provided, there's a ", attributes: attr1)
                    
                    var classProbText = NSMutableAttributedString()
                    var classLabelText = NSMutableAttributedString()
                    if self.classLabel == "positive" {
                         classProbText = NSMutableAttributedString(string: "\(self.classProb)", attributes: attr3)
                         classLabelText = NSMutableAttributedString(string: "Positive for COVID-19.", attributes: attr3)
                    } else {
                         classProbText = NSMutableAttributedString(string: "\(self.classProb)", attributes: attr2)
                         classLabelText = NSMutableAttributedString(string: "Negative for COVID-19.", attributes: attr2)
                    }
                    
                    let partTwo = NSMutableAttributedString(string: "% chance that the user is ", attributes: attr1)
                    
                    let combination = NSMutableAttributedString()
                    combination.append(partOne)
                    combination.append(classProbText)
                    combination.append(partTwo)
                    combination.append(classLabelText)
                    self.results.attributedText = combination
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
        
        titleLabel.text = "RESULT"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: resultsFontSize)
        titleLabel.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: DeviceSize.deviceHeight * 0.1, width: DeviceSize.deviceWidth * 0.9, height:titleLabel.intrinsicContentSize.height)
        self.view.addSubview(titleLabel)

        resultsLabel.text = "Result"
        resultsLabel.font = .systemFont(ofSize: 24)
        resultsLabel.textAlignment = .center
        resultsLabel.textColor = .systemGray
        resultsLabel.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: titleLabel.frame.maxY + DeviceSize.deviceHeight * 0.1, width: DeviceSize.deviceWidth * 0.9, height: resultsLabel.intrinsicContentSize.height)
     //   self.view.addSubview(resultsLabel)
        
        results.text = "Result"
        results.numberOfLines = 0
        results.font = .systemFont(ofSize: 24)
        results.textAlignment = .center
        results.textColor = .systemGray
        results.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: titleLabel.frame.maxY + DeviceSize.deviceHeight * 0.1, width: DeviceSize.deviceWidth * 0.9, height: 200)
        self.view.addSubview(results)
                
        classify(image: testingImage)
        
    }
    
}
