//
//  StarterViewController.swift
//  Game customer App
//
//  Created by Salome Tsiramua on 3/31/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit

class StarterViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        checkIfSavedCredentials()
        
        setBack(hidden: true)
        setHeight()
        setRightButton(hidden: true)
        setShadow(hidden: true)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Do any additional setup after loading the view.
    }
    
    func checkIfSavedCredentials(){
        guard let username = UserDefaults.standard.string(forKey: UserDefaultsKeys.username.rawValue) else {
            pushLogin()
            return
        }
        guard let password = UserDefaults.standard.string(forKey: UserDefaultsKeys.password.rawValue)
            else {
                pushLogin()
            return
        }
        
        NetworkManager.NetworkManagerSharedInstance.register(userName: username, pass: password, callback: { (result) in
            
            if result != nil && result?.status == ResponseStatus.success.rawValue {
                DispatchQueue.main.async {
                    self.pushWallet(result: result!, animated: false)
                }
            }else{
                self.pushLogin()
            }
        })
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
