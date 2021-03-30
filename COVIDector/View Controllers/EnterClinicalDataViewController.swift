//
//  EnterClinicalDataViewController.swift
//  COVIDector
//
//  Created by Kapil on 06/03/21.
//

import UIKit

class EnterClinicalDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var detect = UIButton(type: .system)
    var tableView: UITableView!
    var vitals = ["Haemoglobin", "Platelets Count", "Oxygen Percent", "Leukocytes", "Hematocrit", "Red blood Cells", "Lymphocytes"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
//        cell.textLabel?.text = vitals[indexPath.row]
//        return cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell {
            cell.textLabel?.text = vitals[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonFontSize = 22 * (DeviceSize.deviceWidth / DeviceSize.baseWidth)
        
        detect.setTitle("Detect", for: .normal)
        detect.titleLabel?.font = .systemFont(ofSize: buttonFontSize)
        detect.setTitleColor(.white, for: .normal)
        detect.backgroundColor = .systemGreen
        detect.frame = CGRect(x: DeviceSize.deviceWidth * 0.05, y: DeviceSize.deviceHeight * 0.15, width: DeviceSize.deviceWidth * 0.9, height: detect.intrinsicContentSize.height)
        detect.layer.cornerRadius = detect.frame.height * 0.2
        detect.layer.masksToBounds = false
        detect.addTarget(self, action: #selector(runDetection), for: .touchUpInside)
        self.view.addSubview(detect)
        
        tableView = UITableView(frame: CGRect(x: 0, y: detect.frame.maxY + DeviceSize.deviceWidth * 0.1, width: DeviceSize.deviceWidth, height: DeviceSize.deviceHeight - 10))
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.registerTableViewCells()
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    @objc func runDetection() {
        
    }
    
    
}
