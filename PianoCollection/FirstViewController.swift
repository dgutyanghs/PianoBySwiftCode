//
//  FirstViewController.swift
//  PianoCollection
//
//  Created by  BlueYang on 17/2/11.
//  Copyright © 2017年  BlueYang. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var pianoName:String {
        get {
           return "piano"
        }
    }
//    let fonts: Array <String> = []
    lazy var fontnames:[String] = {
       return UIFont.familyNames
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        containView.backgroundColor = UIColor.gray
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "pianocellid"
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellID)
        }
        
        cell?.textLabel?.text = self.fontnames[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fontnames.count
    }
    

}

