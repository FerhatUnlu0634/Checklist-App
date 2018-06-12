//
//  ItemTBCell.swift
//  Life Checklist
//
//  Created by iDev on 12/06/2018.
//  Copyright © 2018 Ferhat Unlu. All rights reserved.
//

import UIKit

protocol ItemTBCellDelegate {
    func seleted_btn_Item(cell: ItemTBCell)
}

class ItemTBCell: UITableViewCell {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imgChecked: UIImageView!
    @IBOutlet weak var lblItem: UILabel!
    
    var cellDelegate: ItemTBCellDelegate?
    var isChecked: Bool = false {
        didSet {
            setLayout()
        }
    }
    
    func setLayout() {
        viewBackground.backgroundColor = (isChecked) ? BG_COLOR : UIColor.white
        imgChecked.image = UIImage(named: (isChecked) ? "img_Checked" : "img_Unchecked")
        lblItem.textColor = (isChecked) ? UIColor.white : UIColor.black
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func click_btn_Item(_ sender: UIButton) {
        isChecked = !isChecked
        setLayout()
        
        cellDelegate?.seleted_btn_Item(cell: self)
    }
    
    
    
}
