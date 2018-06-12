//
//  AddItemVC.swift
//  Life Checklist
//
//  Created by iDev on 12/06/2018.
//  Copyright © 2018 Ferhat Unlu. All rights reserved.
//

import UIKit

class AddItemVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtItem: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtItem.becomeFirstResponder()
    }

    @IBAction func click_btn_Close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let trimmedString = textField.text?.trimmingCharacters(in: .whitespaces)
        if (textField.text == "" || trimmedString == "") {
            let alertView = UIAlertController(title: "", message: "Please input some text.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
            
            return true
        }
        
        if (DataKeeper.sharedInstance.isContainItem(name: textField.text!)) {
            let alertView = UIAlertController(title: "", message: "This item was already registered. Please choose another one.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
        }else {
            DataKeeper.sharedInstance.arr_Items.append(textField.text!)
            DataKeeper.sharedInstance.arr_Status.append(false)
            DataKeeper.sharedInstance.updateAllData()
            DataKeeper.sharedInstance.isInitialItem = false
            
            self.dismiss(animated: true, completion: nil)
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtItem.resignFirstResponder()
    }
    

}
