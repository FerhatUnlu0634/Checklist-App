//
//  MainVC.swift
//  Life Checklist
//
//  Created by iDev on 12/06/2018.
//  Copyright © 2018 Ferhat Unlu. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MainVC: UIViewController, ItemTBCellDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var viewProgressBG: DesignableView!
    @IBOutlet weak var viewProgress: DesignableView!
    @IBOutlet weak var lblItems: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var view_Admob: UIView!
    
    @IBOutlet weak var widthProgressView: NSLayoutConstraint!
    @IBOutlet weak var heightAdmobView: NSLayoutConstraint!
    
    var arr_Items: [String] = []
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var isLoadedInterstitial: Bool = false
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        runTimer()
        
        if (!DataKeeper.sharedInstance.isPurchased) {
            showAdmobBanner()
            showInterstitial()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        heightAdmobView.constant = (DataKeeper.sharedInstance.isPurchased) ? 0 : 50
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadItems()
    }
    
    func setLayout() {
        tblList.register(UINib(nibName: "ItemTBCell", bundle: nil), forCellReuseIdentifier: "ItemTBCell")
        
        if (DataKeeper.sharedInstance.isPurchased) {
            heightAdmobView.constant = 0
        }
    }
    
    func runTimer() {
        timer = Timer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            if self.interstitial.isReady {
                self.interstitial.present(fromRootViewController: self)
                self.isLoadedInterstitial = true
                timer.invalidate()
            }
        })
    }
    
    //MARK: - Admob
    func showAdmobBanner() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.frame = CGRect(x: (UIScreen.main.bounds.size.width - kGADAdSizeBanner.size.width) / 2 ,
                                  y: 0,
                                  width: kGADAdSizeBanner.size.width,
                                  height: kGADAdSizeBanner.size.height)
        view_Admob.addSubview(bannerView)
        bannerView.adUnitID = Admob_Banner_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func showInterstitial() {
        interstitial = GADInterstitial(adUnitID: Admob_Interstitial_ID)
        let request = GADRequest()
        interstitial.load(request)
    }
    
    //MARK: - UITableView Delegate and DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataKeeper.sharedInstance.arr_Items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemTBCell = self.tblList.dequeueReusableCell(withIdentifier: "ItemTBCell") as! ItemTBCell
        cell.isChecked = DataKeeper.sharedInstance.arr_Status[indexPath.row]
        cell.lblItem.text = DataKeeper.sharedInstance.arr_Items[indexPath.row]
        cell.cellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: - ItemTBCellDelegate
    func seleted_btn_Item(cell: ItemTBCell) {
        let indexPath: IndexPath = tblList.indexPath(for: cell)!
        let isSelected: Bool = DataKeeper.sharedInstance.arr_Status[indexPath.row]
        DataKeeper.sharedInstance.arr_Status.remove(at: indexPath.row)
        DataKeeper.sharedInstance.arr_Status.insert(!isSelected, at: indexPath.row)
        DataKeeper.sharedInstance.updateStatus()
        loadItems()
    }
    
    //MARK: - loadItems
    func loadItems() {
        if (DataKeeper.sharedInstance.isReverseOrder) {
            DataKeeper.sharedInstance.reverseOrderItems()
        }
        countItems()
        tblList.reloadData()
    }
    
    func countItems() {
        if (DataKeeper.sharedInstance.getSumSelectedItems() == 0) {
            lblProgress.text = "0%"
            lblItems.text = "You've Completed 0/\(DataKeeper.sharedInstance.arr_Items.count) items"
        }else {
            lblProgress.text = "\((DataKeeper.sharedInstance.getSumSelectedItems() * 100 / DataKeeper.sharedInstance.arr_Items.count))%"
            lblItems.text = "You've Completed \(DataKeeper.sharedInstance.getSumSelectedItems())/\(DataKeeper.sharedInstance.arr_Items.count) items"
        }
        
        if (DataKeeper.sharedInstance.arr_Items.count > 0) {
            widthProgressView.constant = viewProgressBG.bounds.size.width * (CGFloat)(Float(DataKeeper.sharedInstance.getSumSelectedItems()) / Float(DataKeeper.sharedInstance.arr_Items.count))
        }
    }

}
