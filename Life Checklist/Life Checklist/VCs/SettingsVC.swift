//
//  SettingsVC.swift
//  Life Checklist
//
//  Created by iDev on 12/06/2018.
//  Copyright © 2018 Ferhat Unlu. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    @IBOutlet weak var swInitialItems: UISwitch!
    @IBOutlet weak var swReverseOrder: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setInAppPurchase()
    }
    
    func setLayout() {
        swReverseOrder.isOn = DataKeeper.sharedInstance.isReverseOrder
        swInitialItems.isOn = DataKeeper.sharedInstance.isInitialItem
    }
    
    func setInAppPurchase() {
        IAPHandler.shared.fetchAvailableProducts()
        
        IAPHandler.shared.purchaseStatusBlock = {[weak self] (type) in
            guard let strongSelf = self else{ return }
            if type == .purchased || type == .restored{
                DataKeeper.sharedInstance.isPurchased = true
                DataKeeper.sharedInstance.updatePurchased()
                
                let alertView = UIAlertController(title: "", message: type.message(), preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    
                })
                alertView.addAction(action)
                strongSelf.present(alertView, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - Buttons' Actions
    @IBAction func changed_sw_InitialItems(_ sender: UISwitch) {
        DataKeeper.sharedInstance.isInitialItem = sender.isOn
        DataKeeper.sharedInstance.arr_Items = []
        DataKeeper.sharedInstance.arr_Status = []
        DataKeeper.sharedInstance.updateAllData()
    }
    
    @IBAction func changed_sw_ReverseOrder(_ sender: UISwitch) {
        DataKeeper.sharedInstance.isReverseOrder = sender.isOn
        DataKeeper.sharedInstance.updateReverseOrder()
    }

    @IBAction func click_btn_Close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func click_btn_RemoveAllAds(_ sender: Any) {
        IAPHandler.shared.purchaseMyProduct(index: 0)
    }
    
    @IBAction func click_btn_RestorePurchases(_ sender: Any) {
        IAPHandler.shared.restorePurchase()
    }
    
}
