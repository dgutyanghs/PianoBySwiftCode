//
//  AYNavigationViewController.swift
//  PianoCollection
//
//  Created by AlexYang on 17/3/8.
//  Copyright © 2017年  BlueYang. All rights reserved.
//

import UIKit



class AYNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if  self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let leftBarItem = UIBarButtonItem.init(image: UIImage.init(named: "first"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
            viewController.navigationItem.leftBarButtonItem = leftBarItem
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func back() {
        self.popViewController(animated: true)
    }


}
