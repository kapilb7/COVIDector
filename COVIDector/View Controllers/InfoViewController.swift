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
        infoTextView.text = "Swipe up to change the shape, swipe down to change the color. \n \nYour main aim is to avoid obstacles. The Bar obstacle (Orange colored) can be avoided in any form, color or shape. In the Classic Mode, you must either match the shape or color to overcome the Target obstacle (Purple colored, along with a shape). \n \nBONUS: You will earn Bonus points when you match the shape and color when encoutering a Shape obstacle in this mode!"
        infoTextView.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: titleLabel.frame.maxY + DeviceSize.deviceHeight * 0.05, width: DeviceSize.deviceWidth * 0.9, height: 0)
        infoTextView.sizeToFit()
        self.view.addSubview(infoTextView)
    }
    
    @objc func dissmissInfoViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
