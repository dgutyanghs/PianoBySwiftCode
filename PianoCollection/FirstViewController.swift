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
    var pianoArray = [Array<PianoDataModel>]()
    var pianoLogoArray:[String] = []
    var selectIndexTitleShow:Bool = true
    
    
    
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
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: cellID)
        }
        let piano = pianoArray[indexPath.section][indexPath.row]
        cell?.textLabel?.text = piano.model
        cell?.detailTextLabel?.text = piano.logo
        
        
        return cell!
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if selectIndexTitleShow {
            var logoHeaders = [String]()
            for name in pianoLogoArray {
                let index = name.index(name.startIndex, offsetBy: 1)
                
                let firstLetter:String = name.substring(to: index)
                logoHeaders.append(firstLetter)
            }
            
            return logoHeaders
        }else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headTitle:String?
        
        if pianoArray.count <= 1 {
            headTitle = "查找结果 :(\(pianoArray[section].count) 个型号）"
        }else {
            headTitle = pianoLogoArray[section]
            headTitle = headTitle?.appendingFormat(" (%lu 个型号)", pianoArray[section].count)
        }
       
        return headTitle
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if pianoArray[section].count == 0 {
            return nil
        }
        
        var footerString:String? = nil
        
        if pianoArray.count >= 1 {
            let piano  = pianoArray[section][0]
            footerString = piano.company
        }
        
        return footerString
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return pianoArray[section].count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pianoArray.count
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(tableView) {
            searchBar.resignFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func loadDatabase() -> Void {
         pianoLogoArray = PianoDataModel.loadAllPianoLogo()
         pianoArray = PianoDataModel.loadAllPianos()
    }
    
    
    /// UISearchBarDelegate
    ///
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder();
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pianoArray.removeAll(keepingCapacity: true)
        if searchText == "" {
            pianoArray = PianoDataModel.loadAllPianos()
            selectIndexTitleShow = true
        }else {
            let queryPiano = PianoDataModel.query(text: searchText)
            pianoArray.removeAll(keepingCapacity:true)
            pianoArray.append(queryPiano)
            selectIndexTitleShow = false
        }
        
        tableView.reloadData()
    }
    
    

}

