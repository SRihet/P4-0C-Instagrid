//
//  GridView.swift
//  Instagrid
//
//  Created by Stéphane Rihet on 06/01/2021.
//

import UIKit

class GridView: UIView {

    @IBOutlet weak var MyView: UIView!
    
    @IBOutlet private var selectedLayout1: UIImageView!
    @IBOutlet private var selectedLayout2: UIImageView!
    @IBOutlet private var selectedLayout3: UIImageView!
    
    @IBOutlet var addButton1: UIImageView!
    @IBOutlet var addButton2: UIImageView!
    @IBOutlet var addButton3: UIImageView!
    @IBOutlet var addButton4: UIImageView!
    
    @IBOutlet weak var viewButton2: UIView!
    @IBOutlet weak var viewButton4: UIView!
    
    @IBOutlet var addButtonCollection: [UIImageView]!
    
    var style: GridViewStyle = .topGrid {
        didSet {
            setStyle(style)
        }
    }
    
    private func setStyle(_ style: GridViewStyle) {
        switch style {
        case .topGrid:
            selectedLayout1.isHidden = false
            selectedLayout2.isHidden = true
            selectedLayout3.isHidden = true
            viewButton2.isHidden = true
            viewButton4.isHidden = false

        case .bottomGrid:
            selectedLayout2.isHidden = false
            selectedLayout1.isHidden = true
            selectedLayout3.isHidden = true
            viewButton2.isHidden = false
            viewButton4.isHidden = true

        case .fullGrid:
            selectedLayout3.isHidden = false
            selectedLayout1.isHidden = true
            selectedLayout2.isHidden = true
            viewButton2.isHidden = false
            viewButton4.isHidden = false
        }
    }
    
    //Checking the content of the displayed views image
    func missingImage() -> Bool {
        for imageInGrid in addButtonCollection {
            if imageInGrid.image == nil && imageInGrid.superview!.isHidden == false {
                return true
            }
        }
        return false
    }
}
