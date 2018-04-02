//
//  SignInViewController.swift
//  Game customer App
//
//  Created by Salome Tsiramua on 3/29/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
   
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signInButtonClickAction(_ sender: UIButton) {
        
        //if(userName.text?.isEmpty == false && password.text?.isEmpty == false){
            
            NetworkManager.NetworkManagerSharedInstance.register(userName: userName.text ?? "", pass: password.text ?? "", callback: { (result) in
                
                if result != nil && result?.status == ResponseStatus.success.rawValue {
                    
                    
                    UserDefaults.standard.setValue(self.userName.text ?? "", forKey: UserDefaultsKeys.username.rawValue);
                    UserDefaults.standard.setValue(self.password.text ?? "", forKey: UserDefaultsKeys.password.rawValue)
                    
                    
                    DispatchQueue.main.async {
                        
                        self.pushWallet(result: result!)
                    }
                }else if result != nil && result?.status != ResponseStatus.success.rawValue {
                    DispatchQueue.main.async {
                        self.showAlertWithOneButton(title: result?.status ?? "", message: result?.statusdesc ?? "", okSelector: nil )
                    }
                }
                
                
            })
            
    
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let placeHolderColor = UIColor(white: 1.0, alpha: 0.4)
        let placeHolderFont = UIFont(name: Constants.robotoLight, size: 17)
        
        userName.attributedPlaceholder = NSAttributedString(string: "Email",
                                                            attributes: [NSAttributedStringKey.foregroundColor: placeHolderColor,NSAttributedStringKey.font : placeHolderFont as Any])
        password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                            attributes: [NSAttributedStringKey.foregroundColor: placeHolderColor, NSAttributedStringKey.font : placeHolderFont as Any])
        
        showLogo()
        setHeight()
        setBack(hidden:true)
        setRightButton(hidden: true)
        setShadow(hidden: true)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    
    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        userName.resignFirstResponder()
        password.resignFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        setShadow(hidden: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func showNoInternetView(show: Bool) {
        super.showNoInternetView(show: show)
        signInButton.isEnabled = !show
    }

}
