//
//  BaseViewController.swift
//  Game customer App
//
//  Created by Salome Tsiramua on 3/30/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController {

    @IBOutlet weak var noInternetBottomConstraint: NSLayoutConstraint!
    lazy var  reachabilityManager = Alamofire.NetworkReachabilityManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        listenForReachability()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showNoInternetView(){
        
    }

    
    var isConnectedToNetwork : Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    func listenForReachability() {
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                self.showNoInternetView(show: true)
//                if self.spinner != nil {
//                    UIViewController.removeSpinner(spinner: self.spinner!)
//                }
                
                break
            case .unknown, .reachable(_):
                self.showNoInternetView(show: false)
              
                break
            }
        }
        self.reachabilityManager?.startListening()
    }
    
    func showNoInternetView(show:Bool){
        
        if show == true {
            self.noInternetBottomConstraint.constant = 0
        }else{
            self.noInternetBottomConstraint.constant = 50
        }
        UIView.animate(withDuration: Double(0.5), animations: {
            
            self.view.layoutIfNeeded()
        })
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
