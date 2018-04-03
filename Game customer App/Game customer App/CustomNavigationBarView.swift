//
//  CustomNavigationBarView.swift
//  Game customer App
//
//  Created by Elene Akhvlediani on 4/4/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit



class CustomNavigationBar: UIView {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var line: UIView!
    class func instanceFromNib() -> CustomNavigationBar {
        return UINib(nibName: "CustomNavigationBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomNavigationBar
    }
    
    

}
