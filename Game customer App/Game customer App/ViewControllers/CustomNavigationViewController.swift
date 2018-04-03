//
//  CustomNavigationViewController.swift
//  Game customer App
//
//  Created by Elene Akhvlediani on 4/3/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    var navBar: CustomNavigationBar?
    func addNoInternetView(){
        navBar =  CustomNavigationBar.instanceFromNib()

        self.view.addSubview(navBar!)
        navBar!.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: navBar!, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: navBar!, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: navBar!, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: navBar!, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 87)
        view.addConstraints([horizontalConstraint, bottomConstraint, widthConstraint, heightConstraint])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addNoInternetView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setTitle(title: String?) {
        
        navBar?.logo.isHidden = title != nil
        navBar?.line.isHidden = title == nil
        navBar?.title.isHidden = title == nil
        navBar?.title.text = title
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
