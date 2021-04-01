//
//  InfoViewController.swift
//  COVIDector
//
//  Created by Kapil on 30/03/21.
//

import UIKit

class InfoViewController: UIViewController {
    
    var titleLabel = UILabel()
    var infoTextView = UITextView()
    var closeButton = UIButton(type: .close)
    let titleFontSize = 32 * (DeviceSize.deviceHeight / DeviceSize.baseHeight)
    let inforTextFontSize = 16 * (DeviceSize.deviceHeight / DeviceSize.baseHeight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(self.view.frame.size)
        
        closeButton.frame = CGRect(x: DeviceSize.deviceWidth - 50, y: DeviceSize.deviceHeight * 0.05, width: 40, height: 40)
        closeButton.addTarget(self, action: #selector(dissmissInfoViewController), for: .touchUpInside)
        self.view.addSubview(closeButton)
        
        titleLabel.text = "What is COVIDector?"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: titleFontSize)
        titleLabel.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: DeviceSize.deviceHeight * 0.1, width: DeviceSize.deviceWidth * 0.9, height:titleLabel.intrinsicContentSize.height)
        self.view.addSubview(titleLabel)
        
        
        infoTextView.textAlignment = .left
        infoTextView.isEditable = false
        infoTextView.font = .systemFont(ofSize: inforTextFontSize)
        infoTextView.text = "COVIDector is an app which can predict whether a patient is Negative/Positive for COVID-19, based on AI. \nIt can take two kinds of data, patient's vitals (Haemoglobin, Oxygen Percent, Platelets Count, etc.) or the X-ray image of the patient's lungs. The app after running some Machine/Deep Learning calculations on these data, retuns a Positive/Negative label along with the confidence or probability of the respective prediction. \n \nNOTE: We are not trying to replace any existing gold standard methods of COVID-19 detection, rather we just want to add a complementary option of detection in conjunction with the existing solutions."
        infoTextView.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: titleLabel.frame.maxY + DeviceSize.deviceHeight * 0.05, width: DeviceSize.deviceWidth * 0.9, height: 0)
        infoTextView.sizeToFit()
        self.view.addSubview(infoTextView)
    }
    
    @objc func dissmissInfoViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
