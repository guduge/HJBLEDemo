//
//  BleCharacteristicsViewController.swift
//  HJBLEDemo
//
//  Created by 赵优路 on 2020/4/24.
//  Copyright © 2020 thj. All rights reserved.
//

import UIKit

class BleCharacteristicsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "characteristics list"
        setupUI()
        BLEManager.shared.discoverCharacteristicsForserviceBlok = { [weak self] in
            self?.tableView.reloadData()
        }
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         
    }
    deinit {
        BLEManager.shared.selectBleData.characteristics.removeAll()
    }
    fileprivate func setupUI() {
        self.view.addSubview(self.tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        tableView.reloadData()
    }
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.backgroundColor = UIColor.white
        view.tableFooterView = UIView()
        return view
    }()
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension BleCharacteristicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let character  = BLEManager.shared.selectBleData.characteristics[indexPath.row]
//        BLEManager.shared.getVersion(characteristic: character)
        BLEManager.shared.selectBleData.characteristic = character
        self.navigationController?.pushViewController(BLEConnectSuccessViewController(), animated: true)
//        BLEManager.shared.writeValue(dict: ["name":"thj"], characteristic: character)
        
        
    }
}
extension BleCharacteristicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BLEManager.shared.selectBleData.characteristics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        ///CBCharacteristic
        let character = BLEManager.shared.selectBleData.characteristics[indexPath.row]
        var str = ""
        switch character.properties {
        case .read:
            str = "可读"
        case .write, .writeWithoutResponse:
            str = "可写"
        case .broadcast:
            str = "广播"
//        case .notify:
//            str = "notify"
//        case .notifyEncryptionRequired:
//            str = "notifyEncryptionRequired"
        default:
            break
        }
        cell.textLabel?.text =  str + "UUID:" + character.uuid.uuidString
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
