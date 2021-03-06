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
    var bottomConstraint: NSLayoutConstraint?
    var alertVC:UIAlertController?
    
    lazy var titleLabel :UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: Constants.robotoLight, size: 20)
        label.textColor = UIColor.white
        
        return label
        
    }()
    
    var noInternetView:UIView?
    func addNoInternetView(){
        noInternetView =  Bundle.main.loadNibNamed("NoInternet", owner: nil, options: nil)![0] as? UIView
        //noInternetView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35)
        self.view.addSubview(noInternetView!)
        noInternetView?.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: noInternetView!, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: noInternetView!, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 50)
        self.bottomConstraint = bottomConstraint
        let widthConstraint = NSLayoutConstraint(item: noInternetView!, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: noInternetView!, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 35)
        view.addConstraints([horizontalConstraint, bottomConstraint, widthConstraint, heightConstraint])
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNoInternetView()
        listenForReachability()
        (self.navigationController as? CustomNavigationViewController)?.navBar?.logoutButton.addTarget(self, action: #selector(logoutButtonClick), for: .touchUpInside)
        // Do any additional setup after loading the view.
        showNoInternetView(show: !isConnectedToNetwork, animated: false)
        
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLogo(){
        (self.navigationController as? CustomNavigationViewController)?.setTitle(title: nil)

//        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "headerLogo"))
    }
    
    func setShadow(hidden : Bool){
        
        if(hidden == true){
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }else{
           
           self.navigationController?.navigationBar.shadowImage = UIImage.from(color: UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1))
            
        
        }
        
        
    }
 
    
    func setTitle(title:String){
        (self.navigationController as? CustomNavigationViewController)?.setTitle(title: title)
//        titleLabel.text = title
//        self.navigationItem.titleView = titleLabel
        
    }
    
    func setRightButton(hidden:Bool){
        (self.navigationController as? CustomNavigationViewController)?.navBar?.logoutButton.isHidden = hidden
        if hidden == false {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: self, action: #selector(BaseViewController.logoutButtonClick))
        }
        
    }
    @objc func logoutButtonClick(){
        if(isConnectedToNetwork == false){
            return
        }
        DispatchQueue.main.async {
            self.showAlertWithTwoButtons(title: "", message: "Are you sure you want to sign out?", okSelector: self.logout, secondSelector: nil )
        }
        //logout()
    }
    
    
    
    func logout(){
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.username.rawValue)
        
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.password.rawValue)
        
        NetworkManager.NetworkManagerSharedInstance.unRegister { (result) in
            DispatchQueue.main.async {
                self.pushLogin()
            }
            
        }
        
        
        
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
                self.showNoInternetView(show: true, animated: true)
//                if self.spinner != nil {
//                    UIViewController.removeSpinner(spinner: self.spinner!)
//                }
                
                break
            case .unknown, .reachable(_):
                self.showNoInternetView(show: false, animated: true)
              
                break
            }
        }
        self.reachabilityManager?.startListening()
    }
    
    
    func pushLogin(userName:String = "", password:String = ""){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SignInViewController.className) as! SignInViewController
        vc.passedUsername = userName
        vc.passedPassword = password
        
        self.navigationController?.pushViewController(vc, animated: false)
        
        
        
    }
    
    func pushWallet(result:RegistrationResult, animated:Bool){
        let vc = UIStoryboard(name: Constants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: GameWalletViewController.className) as! GameWalletViewController
        vc.result = result
        
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    func setBack(hidden:Bool){
        if hidden == true {
            self.navigationItem.backBarButtonItem = nil
        
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        
    }
    func showNoInternetView(show:Bool, animated:Bool){
 
        if show == true {
            self.bottomConstraint?.constant = 0
        }else{
            self.bottomConstraint?.constant = 50
        }
        if animated {
            UIView.animate(withDuration: Double(0.5), animations: {
                
                self.view.layoutIfNeeded()
            })
        }else{
            self.view.layoutIfNeeded()
        }
        
    }
    
    func showAlertWithTwoButtons(title:String, message:String, okSelector: (() -> Void?)?,secondSelector:(() -> Void?)?){
        showAlertWithTitle(title: title, message: message, okSelector: okSelector, secondSelector: secondSelector, oneButton: false)

    }
    
    func showAlertWithOneButton(title:String, message:String, okSelector: (() -> Void?)?) {
        showAlertWithTitle(title: title, message: message, okSelector: okSelector, secondSelector: nil)
    }
    
    func showAlertWithTitle( title:String, message:String, okSelector: (() -> Void?)?, secondSelector:(() -> Void?)?, oneButton:Bool = true) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: oneButton ? "Ok" : "Yes"  , style: .default) { _ in
           okSelector?()
        }
        
        
        okAction.setValue(Constants.pinkColor, forKey: "titleTextColor")
       
        alertVC.addAction(okAction)
        if !oneButton {
            let noAction = UIAlertAction(title: "No"  , style: .default) { _ in
                secondSelector?()
            }
            noAction.setValue(Constants.grayColor, forKey: "titleTextColor")
            
            alertVC.addAction(noAction)
        }
        
        
        
        DispatchQueue.main.async() { () -> Void in
            
            if self.presentedViewController == nil {
                

                self.view.window?.rootViewController?.present(alertVC, animated: true, completion: nil)
//                self.present(alertVC, animated: true, completion: nil)
            }
            
        }
    }


}


