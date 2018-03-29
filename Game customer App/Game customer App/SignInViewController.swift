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
                        //self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: true)
                    }
                }
                
                
            })
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
