//
//  FirstViewController.swift
//  PianoCollection
//
//  Created by  BlueYang on 17/2/11.
//  Copyright © 2017年  BlueYang. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {

    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var pianoArray:[PianoDataModel] = []
    var pianoLogoArray:[String] = []
    
    
    var pianoName:String {
        get {
           return "piano"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadDatabase()
        
        containView.backgroundColor = UIColor.gray
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
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
        let piano = pianoArray[indexPath.row]
        cell?.textLabel?.text = piano.model
        cell?.detailTextLabel?.text = piano.logo
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pianoArray.count
        
    }
    
    func loadDatabase() -> Void {
        
        let fileURLPath = Bundle.main.path(forResource: "AlexPianoDataBase", ofType: "sqlite")
        guard let database  = FMDatabase(path: fileURLPath)
            else {
                print("unable to create a databse")
                return
        }
        
        guard database.open() else {
            print("unable to open data base")
            return
        }
        // get all Piano's logo
        do {
                let rs = try database.executeQuery("select DISTINCT logo  from JapanUsedPiano_copy order by logo asc;", values: nil)
            
                while rs.next() {
                    let logo = rs.string(forColumn: "logo")
                    pianoLogoArray.append(logo!)
                }
            
            } catch let error as NSError {
                print("database logo error:\(error.localizedDescription)")
            }
        
        // get all piano's model
        do {
            for logo in pianoLogoArray {
                let sql = "select * from JapanUsedPiano_copy where logo = '\(logo)';"
                let rs  = try database.executeQuery(sql, values: nil)
                
                while rs.next() {
                    let id          = rs.int(forColumn: "id")
                    let company     = rs.string(forColumn: "company")
                    let logo        = rs.string(forColumn: "logo")
                    let model       = rs.string(forColumn: "model")
                    let hight       = rs.string(forColumn: "hight")
                    let width       = rs.string(forColumn: "width")
                    let length      = rs.string(forColumn: "length")
                    let height      = rs.string(forColumn: "height")
                    let since       = rs.string(forColumn: "since")
                    let end         = rs.string(forColumn: "end")
                    let price       = rs.string(forColumn: "price")
                    let kind        = rs.string(forColumn: "kind")
                    let color       = rs.string(forColumn: "color")
                    let selection   = rs.string(forColumn: "selection")
                    let remarks     = rs.string(forColumn: "remarks")
                    
                    
                    let pianoModel = PianoDataModel(id: Int(id), company: company, logo: logo, model: model, hight: hight, width: width, length: length, height: height, since: since, end: end, price: price, kind: kind, color: color, selection: selection, remarks: remarks)
                    
                    pianoArray.append(pianoModel)
                }
            }
            
        } catch let error as NSError {
            print("database query piano failed:\(error.localizedDescription)")
        }
        
    }
    

}

