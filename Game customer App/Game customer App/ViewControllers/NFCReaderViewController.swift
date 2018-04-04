
//
//  NFCReaderViewController.swift
//  Game customer App
//
//  Created by Salome Tsiramua on 3/30/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit
import LocalAuthentication

class NFCReaderViewController: BaseViewController, NFCReaderDelegate {
   

    var tid: String?
    @IBOutlet weak var goodsAmountLabel: UILabel!
    
    @IBOutlet weak var creditsAmountLabel: UILabel!
    
    @IBOutlet weak var touchIDLogo: UIImageView!
    
    @IBOutlet weak var terminalLogo: UIImageView!
    @IBOutlet weak var aboveLabel: UILabel!
  
    
    @IBOutlet weak var pinkButton: UIButton!
    
    @IBOutlet weak var opaqueButton: UIButton!
    
    let nfcReader = NFCReader()
    
    @IBOutlet weak var overTouchIDButton: UIButton!
    
    @IBAction func overTouchIDButtonClickAction(_ sender: UIButton) {
        
        checkTouchID()
    }
    var loadingViewController: LoadingViewController?
    
    @IBAction func pinkButtonClickAction(_ sender: UIButton) {
      //  addLoadingView()
        if touchIDLogo.isHidden {
            nfcReader.beginSession()
        } else {
           // addLoadingView()
            let s = StatusToSet.denied
            NetworkManager.NetworkManagerSharedInstance.setAuthStatus(tid: tid!, status: s) { ststus in
                
                DispatchQueue.main.async {
                  //  self.removeLoadingView()
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    
    @IBAction func opaqueButtonClickAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func addLoadingView(){
        loadingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController
        loadingViewController?.modalPresentationStyle = .overCurrentContext
        loadingViewController?.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(loadingViewController!, animated: true, completion: nil)
    }
    @objc func removeLoadingView(block: (() -> Void)?){
        loadingViewController?.dismiss(animated: true, completion: block)
        loadingViewController = nil
    }
   
    func getResult(result: String) {
        tid = result
        print("modis")
        addLoadingView()
        let timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: (#selector(removeLoadingView)), userInfo: nil, repeats: false)
        NetworkManager.NetworkManagerSharedInstance.fetchData(tid: result) { data in
            
            
            
            DispatchQueue.main.async {
                timer.invalidate()
                self.removeLoadingView(block: {
                    if data?.status == ResponseStatus.success.rawValue {
                        print("successssssssssssssssssssss")
                        self.updateInfoOnGoodsAndCredits(data: data!)
                    }else{
                        print("failllllllllll")
                        self.showAlertWithTitle(title: (data?.statusdesc)!, message:ResponseStatus.getErrorDesc(errorCode: (data?.status)!).rawValue, okAction: .returnToScanNFC)
                    }
                })
           
                
                
            }
        }
    }
    func updateInfoOnGoodsAndCredits(data: TransactionResult) {
        if data.category?.contains("topup") == true {
            goodsAmountLabel.text = "Top up"
            creditsAmountLabel.text  = data.totalcredits?.description
        }else {
            if data.category?.contains("game") == true {
                creditsAmountLabel.text  = data.totalcredits?.description
                if data.articles?.count == 1 {
                    goodsAmountLabel.text = data.articles![0].name
                }else{
                    goodsAmountLabel.text = "Playtime"
                }
            }else if data.category?.contains("food") == true {
                creditsAmountLabel.text  = data.totalcredits?.description
                if data.articles?.count == 1 {
                    goodsAmountLabel.text = data.articles![0].name
                }else{
                    goodsAmountLabel.text = "Food & Drinks"
                }
            }
            
            if data.totalcredits! > data.creditbalance! {
                let text = "Sorry your credit balance is too low! Please top up your account!"
                showAlertWithOneButton(title: "", message: text, okSelector: goBackToWallet)
                return
            }
        }
        self.updateScreenTo(touchID: true)

    }
    func goBackToWallet() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateScreenTo(touchID:Bool){
        pinkButton.isEnabled = true
        pinkButton.alpha = 1
        
        self.overTouchIDButton.isEnabled = touchID
        
        if touchID == true {
            self.aboveLabel.text = "Confirm with TouchID"
            self.touchIDLogo.isHidden = false
            self.terminalLogo.isHidden = true
            self.pinkButton.setTitle("Cancel", for: .normal)
            self.opaqueButton.isHidden = true
            checkTouchID()
        }else{
            
            self.touchIDLogo.isHidden = true
            self.terminalLogo.isHidden = false
            self.pinkButton.setTitle("Start Search", for: .normal)
            creditsAmountLabel.text = "--"
            creditsAmountLabel.text = "--"
            self.aboveLabel.text = "Hold near terminal"
            self.opaqueButton.isHidden = false
            //self.currTransactionResult = nil
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nfcReader.nfcReaderDelegate = self
        // Do any additional setup after loading the view.
        opaqueButton.layer.borderColor = UIColor(red: 234/256, green: 234/256, blue: 234/256, alpha: 1).cgColor
        opaqueButton.layer.borderWidth = 1
        
        setHeight()
        setTitle(title: "NFC")
        setBack(hidden: true)
        setRightButton(hidden: false)
        setShadow(hidden: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkTouchID() {
        // 1. Create a authentication context
        let authenticationContext = LAContext()
        authenticationContext.localizedFallbackTitle = ""
        var error:NSError?
        
        // 2. Check if the device has a fingerprint sensor
        // If not, show the user an alert view and bail out!
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
            
        }
        
        // 3. Check the fingerprint
        
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Put finger on sensor to confirm purchase",
            
            reply: { [unowned self] (success, error) -> Void in
                
                if( success ) {
                    
                    let s = StatusToSet.authorized
                    NetworkManager.NetworkManagerSharedInstance.setAuthStatus(tid: self.tid!, status: s) { status in
                        
                        DispatchQueue.main.async {
                            if status?.status == ResponseStatus.success.rawValue {
                                self.getTransactionStatus(id: status?.tid)
                                self.addLoadingView()
                            } else{
                                self.showAlertWithTitle(title: (status?.statusdesc)!, message: SetStatusResponseCode.getErrorDesc(errorCode: (status?.status)!), okAction: OkButtonActions.showFail)
                            }
                        }
                    }
  
                    
                }else {
                    
                    // Check if there is an error
                    if let error = error {
                        
                        //    let message = self.errorMessageForLAErrorCode(errorCode: (error as NSError).code)
                        //
                        if error.code == LAError.authenticationFailed.rawValue {
                            let s = StatusToSet.failed
                            NetworkManager.NetworkManagerSharedInstance.setAuthStatus(tid: self.tid!, status: s) { status in
                                
                            }
                        }
                        
                    }
                    
                }
                
        })
    }

    
    func getTransactionStatus(id: String?){
        NetworkManager.NetworkManagerSharedInstance.getTransactionStatus(tid: id!) { result in
            DispatchQueue.main.async {
                self.removeLoadingView(block: {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ResultViewController.className) as! ResultViewController
                    vc.result = result
                    self.navigationController?.pushViewController(vc, animated: true)
                })
            }
            
            
        }
    }
    
    
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        
        showAlertWithTitle(title: "Error", message: "Activate TouchID sensor.", okAction: .doNothing)
        
    }
    
    func showAlertViewAfterEvaluatingPolicyWithMessage( message:String ){
        
        showAlertWithTitle(title: "Error", message: message)
        
    }
    
    func showAlertWithTitle( title:String, message:String, okAction:OkButtonActions = OkButtonActions.doNothing) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            if okAction == .doNothing {
                
            }else if okAction == .showFail {
                
                //self.showResultView(success: false)
            }else if okAction == .returnToScanNFC{
                
                //self.updateScreenTo(touchID: false)
                
            }
        }
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async() { () -> Void in
            
            self.present(alertVC, animated: true, completion: nil)
            
        }
       
    }
    func alert(title: String, message: String, okAction: OkButtonActions) {
        DispatchQueue.main.async {
            self.showAlertWithTitle(title: title, message: message, okAction: okAction)
        }
        
    }
    
    
    override func showNoInternetView(show: Bool) {
        super.showNoInternetView(show: show)
        pinkButton.isEnabled = !show
        opaqueButton.isEnabled = !show
        
        
        if(self.touchIDLogo.isHidden == false){
            overTouchIDButton.isEnabled = !show
        }
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
