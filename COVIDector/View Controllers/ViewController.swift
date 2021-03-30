//
//  ViewController.swift
//  COVIDector
//
//  Created by Kapil on 28/02/21.
//

import UIKit
struct DeviceSize {
    static var deviceWidth = CGFloat(0.0)
    static var deviceHeight = CGFloat(0.0)
    static var baseWidth = CGFloat(414)
    static var baseHeight = CGFloat(896)
}

class ViewController: UIViewController {
    
    
    var enterClinicalData = UIButton(type: .system)
    var uploadChestImage = UIButton(type: .system)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        DeviceSize.deviceWidth = self.view.frame.width
        DeviceSize.deviceHeight = self.view.frame.height
        let buttonFontSize = 26 * (DeviceSize.deviceWidth / DeviceSize.baseWidth)
        
        enterClinicalData.setTitle("Enter Clinical Vitals", for: .normal)
        enterClinicalData.titleLabel?.font = .systemFont(ofSize: buttonFontSize)
        enterClinicalData.setTitleColor(.white, for: .normal)
        enterClinicalData.backgroundColor = .systemBlue
        enterClinicalData.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: self.view.frame.height / 2 - DeviceSize.deviceHeight * 0.1, width: DeviceSize.deviceWidth * 0.9 , height: enterClinicalData.intrinsicContentSize.height)
        enterClinicalData.layer.cornerRadius = enterClinicalData.frame.height * 0.2
        enterClinicalData.layer.masksToBounds = false
        enterClinicalData.addTarget(self, action: #selector(goToEnterClinicalData), for: .touchUpInside)
        self.view.addSubview(enterClinicalData)
        
        uploadChestImage.setTitle("Upload X-ray Image", for: .normal)
        uploadChestImage.titleLabel?.font = .systemFont(ofSize: buttonFontSize)
        uploadChestImage.setTitleColor(.white, for: .normal)
        uploadChestImage.backgroundColor = .systemBlue
        uploadChestImage.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: self.view.frame.height / 2 + DeviceSize.deviceHeight * 0.1, width: DeviceSize.deviceWidth * 0.9 , height: enterClinicalData.intrinsicContentSize.height)
        uploadChestImage.layer.cornerRadius = uploadChestImage.frame.height * 0.2
        uploadChestImage.layer.masksToBounds = false
        uploadChestImage.addTarget(self, action: #selector(goToUploadXrayImage), for: .touchUpInside)
        self.view.addSubview(uploadChestImage)
        
    }
    
    @objc func goToEnterClinicalData() {
        performSegue(withIdentifier: "toEnterClinicalData", sender: nil)
    }
    
    @objc func goToUploadXrayImage() {
        performSegue(withIdentifier: "toUploadXrayImage", sender: nil)
    }


}

