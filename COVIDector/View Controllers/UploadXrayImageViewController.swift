//
//  UploadXrayImageViewController.swift
//  COVIDector
//
//  Created by Kapil on 06/03/21.
//

import UIKit

class UploadXrayImageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var uploadFromDevice = UIButton(type: .system)
    var XrayView = UIImageView()
    var isImageLoaded = false
    var detect = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonFontSize = 22 * (DeviceSize.deviceWidth / DeviceSize.baseWidth)
        
        uploadFromDevice.setTitle("Upload X-ray Image", for: .normal)
        uploadFromDevice.titleLabel?.font = .systemFont(ofSize: buttonFontSize)
        uploadFromDevice.setTitleColor(.white, for: .normal)
        uploadFromDevice.backgroundColor = .systemBlue
        uploadFromDevice.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: self.view.frame.height - DeviceSize.deviceHeight * 0.1, width: DeviceSize.deviceWidth * 0.9 , height: uploadFromDevice.intrinsicContentSize.height)
        uploadFromDevice.layer.cornerRadius = uploadFromDevice.frame.height * 0.2
        uploadFromDevice.layer.masksToBounds = false
        uploadFromDevice.addTarget(self, action: #selector(importPicture), for: .touchUpInside)
        self.view.addSubview(uploadFromDevice)
        
        XrayView.frame = CGRect(x: DeviceSize.deviceWidth / 2 - DeviceSize.deviceWidth * 0.375, y: DeviceSize.deviceHeight / 2 - DeviceSize.deviceWidth * 0.375, width: DeviceSize.deviceWidth * 0.75, height: DeviceSize.deviceWidth * 0.75)
        XrayView.contentMode = .scaleAspectFit
        _ = UIImage(systemName: "arrow.up.doc.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64, weight: .light, scale: .large))
        XrayView.image = UIImage(named: "Placeholder")//placeholder
        self.view.addSubview(XrayView)
        
        detect.setTitle("Detect", for: .normal)
        detect.titleLabel?.font = .systemFont(ofSize: buttonFontSize)
        detect.setTitleColor(.white, for: .normal)
        detect.backgroundColor = .systemGreen
        detect.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: DeviceSize.deviceHeight * 0.15, width: DeviceSize.deviceWidth * 0.9, height: uploadFromDevice.intrinsicContentSize.height)
        detect.layer.cornerRadius = detect.frame.height * 0.2
        detect.layer.masksToBounds = false
        detect.addTarget(self, action: #selector(runDetection), for: .touchUpInside)
        self.view.addSubview(detect)
        
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        isImageLoaded = true
        XrayView.image = image
    }
    
    @objc func runDetection() {
        if !isImageLoaded {
            print("No X-ray Image loaded to be detected...")
            let alertController = UIAlertController(title: "No X-ray Image Uploaded!", message: "Please upload an X-ray Image first, to detect for COVID-19 Positive/Negative.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "XrayToResult", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "XrayToResult") {
            let vc = segue.destination as! ResultViewController
            vc.testingImage = XrayView.image!
        }
    }

}
