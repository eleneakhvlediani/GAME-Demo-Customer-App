//
//  SignInViewController.swift
//  Game customer App
//
//  Created by Salome Tsiramua on 3/29/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
   
    
    @IBAction func signInButtonClickAction(_ sender: UIButton) {
        
        if(userName.text?.isEmpty == false && password.text?.isEmpty == false){
            NetworkManager.NetworkManagerSharedInstance.register(userName: userName.text ?? "", pass: password.text ?? "", callback: { (result) in
                
                if result?.status == ResponseStatus.success.rawValue {
                    
                    
                    UserDefaults.standard.setValue(self.userName.text ?? "", forKey: UserDefaultsKeys.username.rawValue);
                    UserDefaults.standard.setValue(self.password.text ?? "", forKey: UserDefaultsKeys.password.rawValue)
                    
                    
                    DispatchQueue.main.async {
                        
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameWalletViewController") as! GameWalletViewController
                        vc.result = result

                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
                
            })
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let placeHolderColor = UIColor(white: 1.0, alpha: 0.4)
        let placeHolderFont = UIFont(name: Constants.robotoLight, size: 17)
        
        userName.attributedPlaceholder = NSAttributedString(string: "Email",
                                                            attributes: [NSAttributedStringKey.foregroundColor: placeHolderColor,NSAttributedStringKey.font : placeHolderFont as Any])
        password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                            attributes: [NSAttributedStringKey.foregroundColor: placeHolderColor, NSAttributedStringKey.font : placeHolderFont as Any])
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
