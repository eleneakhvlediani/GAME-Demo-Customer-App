
//
//  NFCReaderViewController.swift
//  Game customer App
//
//  Created by Salome Tsiramua on 3/30/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit

class NFCReaderViewController: UIViewController {

    
    @IBOutlet weak var goodsAmountLabel: UILabel!
    
    @IBOutlet weak var creditsAmountLabel: UILabel!
    
    @IBOutlet weak var touchIDLogo: UIImageView!
    
    @IBOutlet weak var terminalLogo: UIImageView!
    @IBOutlet weak var aboveLabel: UILabel!
  
    
    @IBOutlet weak var pinkButton: UIButton!
    
    @IBOutlet weak var opaqueButton: UIButton!
    
    @IBAction func pinkButtonClickAction(_ sender: UIButton) {
        
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func opaqueButtonClickAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        opaqueButton.layer.borderColor = UIColor(red: 234/256, green: 234/256, blue: 234/256, alpha: 1).cgColor
        opaqueButton.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
