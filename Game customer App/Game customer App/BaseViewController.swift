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

    
    lazy var titleLabel :UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: Constants.robotoLight, size: 20)
        label.textColor = UIColor.white
        
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       // listenForReachability()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLogo(){
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "headerLogo"))
    }
    
    func setShadow(hidden : Bool){
        
        if(hidden == true){
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }else{
           
           self.navigationController?.navigationBar.shadowImage = UIImage.from(color: UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1))
            
        
        }
        
        
    }
 
    
    func setTitle(title:String){
        titleLabel.text = title
        self.navigationItem.titleView = titleLabel
        
    }
    
    func setRightButton(hidden:Bool){
        if hidden == true {
            self.navigationItem.rightBarButtonItem = nil
        }else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: self, action: #selector(BaseViewController.logoutButtonClick))
        }
        
    }
    @objc func logoutButtonClick(){
        
        //first show alert
        logout()
    }
    
    func logout(){
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.username.rawValue)
        
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.password.rawValue)
        
        pushLogin()
        
    }
    
    func showNoInternetView(){
        
    }
    func setHeight(){
       // self.navigationItem.prompt = " "
        
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//
    
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationItem.backBarButtonItem = nil
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
    
    
    func pushLogin(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SignInViewController.className) as! SignInViewController
        
        self.navigationController?.pushViewController(vc, animated: false)
        
        
        
    }
    
    func pushWallet(result:RegistrationResult){
        let vc = UIStoryboard(name: Constants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: GameWalletViewController.className) as! GameWalletViewController
        vc.result = result
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setBack(hidden:Bool){
        if hidden == true {
            self.navigationItem.backBarButtonItem = nil
        
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        
    }
    func showNoInternetView(show:Bool){
        
//        if show == true {
//            self.noInternetBottomConstraint.constant = 0
//        }else{
//            self.noInternetBottomConstraint.constant = 50
//        }
//        UIView.animate(withDuration: Double(0.5), animations: {
//
//            self.view.layoutIfNeeded()
//        })
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


