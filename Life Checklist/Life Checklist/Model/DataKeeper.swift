//
//  DataKeeper.swift
//  Life Checklist
//
//  Created by iDev on 12/06/2018.
//  Copyright © 2018 Ferhat Unlu. All rights reserved.
//

import Foundation

class DataKeeper: NSObject {
    class var sharedInstance: DataKeeper{
        struct Singleton{ static let instance = DataKeeper() }
        return Singleton.instance
    }
    
    var arr_Status: [Bool] = []
    var arr_Items: [String] = []
    var isReverseOrder: Bool = false
    var isPurchased: Bool = false
    var isInitialItem: Bool = false
    
    func initData() {
        arr_Status = []
        arr_Items = []
        arr_Status = []
    }
    
    func getAllData() {
        getReverseOrder()
        getItems()
        getStatus()
        
        //add default items
        if (arr_Items.count == 0) {
            addDefaultItems()
        }
    }
    
    func updateAllData() {
        updateReverseOrder()
        updateItems()
        updateStatus()
    }
    
    //MARK: - ReverseOrder
    func getReverseOrder(){
        isReverseOrder = false
        if ((prefs.object(forKey: "isReverseOrder")) != nil){
            isReverseOrder = prefs.object(forKey: "isReverseOrder") as! Bool
        }
    }
    
    func updateReverseOrder(){
        prefs.set(isReverseOrder, forKey: "isReverseOrder")
        prefs.synchronize()
    }
    
    //MARK: - Purchased
    func getPurchased(){
        isPurchased = false
        if ((prefs.object(forKey: "isPurchased")) != nil){
            isPurchased = prefs.object(forKey: "isPurchased") as! Bool
        }
    }
    
    func updatePurchased(){
        prefs.set(isPurchased, forKey: "isPurchased")
        prefs.synchronize()
    }
    
    //MARK: - Items
    func getItems(){
        arr_Items = []
        var arr: [String] = []
        
        if ((prefs.object(forKey: "arr_Items")) != nil){
            arr = prefs.object(forKey: "arr_Items") as! [String]
            for str in arr {
                arr_Items.append(str)
            }
        }
    }
    
    func updateItems(){
        prefs.set(arr_Items, forKey: "arr_Items")
        prefs.synchronize()
    }
    
    //MARK: - Status
    func getStatus(){
        arr_Status = []
        var arr: [Bool] = []
        
        if ((prefs.object(forKey: "arr_Status")) != nil){
            arr = prefs.object(forKey: "arr_Status") as! [Bool]
            for flag in arr {
                arr_Status.append(flag)
            }
        }
    }
    
    func updateStatus(){
        prefs.set(arr_Status, forKey: "arr_Status")
        prefs.synchronize()
    }
    
    //MARK: - Reverse Order
    func reverseOrderItems() {
        var arr_temp_Items: [String] = []
        var arr_temp_Status: [Bool] = []
        
        //Move unselected items
        for i in 0..<arr_Items.count{
            if (arr_Status[i] == false) {
                arr_temp_Items.append(arr_Items[i])
                arr_temp_Status.append(arr_Status[i])
            }
        }
        
        //Remove unselected items
        var index: Int = 0
        while arr_Items.count > index {
            if (arr_Status[index] == false) {
                arr_Status.remove(at: index)
                arr_Items.remove(at: index)
            }else {
                index = index + 1
            }
        }
        
        //Move selected items
        for i in 0..<arr_Items.count{
            arr_temp_Items.append(arr_Items[i])
            arr_temp_Status.append(arr_Status[i])
        }
        
        arr_Items = arr_temp_Items
        arr_Status = arr_temp_Status
        
        updateAllData()
    }
    
    func isContainItem(name: String) -> Bool {
        let retVal = false
        for item in arr_Items {
            if (item == name) { return true }
        }
        return retVal
    }
    
    func getSumSelectedItems() -> Int{
        var sum: Int = 0
        for status in arr_Status {
            if (status == true) { sum = sum + 1}
        }
        return sum
    }
    
    // add default items
    func addDefaultItems() {
        for item in default_Items {
            arr_Items.append(item)
            arr_Status.append(false)
        }
    }
}
