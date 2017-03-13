//
//  PianoDataModel.swift
//  PianoCollection
//
//  Created by AlexYang on 17/3/10.
//  Copyright © 2017年  BlueYang. All rights reserved.
//

import Foundation
import UIKit

private var pianoLogoArray:[String] = []
private var pianos = [Array<PianoDataModel>]()

struct PianoDataModel {
    let  id :Int
    let  company:String?
    let  logo:String?
    let  model: String?
    let  hight: String?
    let  width: String?
    let  length:String?
    let  height:String?
    let  since:String?
    let  end: String?
    let  price: String?
    let  kind: String?
    let  color: String?
    let  selection: String?
    let  remarks: String?
    
    
    static let pianoDatabase:FMDatabase? = {
        let fileURLPath = Bundle.main.path(forResource: "AlexPianoDataBase", ofType: "sqlite")
        guard let database  = FMDatabase(path: fileURLPath)
            else {
                print("unable to create a databse")
                return nil
        }
        
        return database
    }()
    
//    private var pianoLogoArray:[String] = []
    static public func loadAllPianoLogo() -> [String] {
        
        guard (pianoDatabase?.open()) != nil
            else {
                print("database open error")
                return []
        }
        
        // get all Piano's logo
        do {
                let rs = try pianoDatabase!.executeQuery("select DISTINCT logo  from JapanUsedPiano_copy order by logo asc;", values: nil)
            
                while rs.next() {
                    let logo = rs.string(forColumn: "logo")
                    pianoLogoArray.append(logo!)
                }
            
            } catch let error as NSError {
                print("database logo error:\(error.localizedDescription)")
            }
        
        return pianoLogoArray;
    }
    
    static func loadAllPianos() -> [Array<PianoDataModel>]  {
        if pianoLogoArray.count == 0 {
            _ = loadAllPianoLogo()
        }
        
        // get all piano's model
        do {
            for logo in pianoLogoArray {
                var pianoInLogo = [PianoDataModel]()
                
                let sql = "select * from JapanUsedPiano_copy where logo = '\(logo)';"
                let rs  = try pianoDatabase!.executeQuery(sql, values: nil)
                
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
                    
                    pianoInLogo.append(pianoModel)
                }
                
                pianos.append(pianoInLogo)
            }
            
        } catch let error as NSError {
            print("database query piano failed:\(error.localizedDescription)")
        }
        
        return pianos;
        
    }
    
    
    static func getLogos() -> [String] {
        if pianoLogoArray.count == 0 {
            _ =  loadAllPianoLogo()
        }
        
        return pianoLogoArray;
    }
    
    static func query(text:String) -> [PianoDataModel] {
        var queryResult:[PianoDataModel] = []
        
        
        // get all piano's model
        do {
            let sql = "select * from JapanUsedPiano_copy where  model like '\(text)%%' or logo like '\(text)%%' order by logo;"
            let rs  = try pianoDatabase!.executeQuery(sql, values: nil)
            
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
                
                queryResult.append(pianoModel)
            }
            
        } catch let error as NSError {
            print("database query piano failed:\(error.localizedDescription)")
        }
        
        return queryResult;
    }
}


//    init(id:NSInteger, company:String?, logo:String?, model:String?, hight:String?, width:String?, length:String?, height:String?, since:String?, end:String?, price:String?, kind:String?, color:String?, selection:String?, remarks:String?) {
//    init(id:Int, company:String, logo:String, model:String, hight:String, width:String, length:String, height:String, since:String, end:String, price:String, kind:String, color:String, selection:String, remarks:String) {
//        self.id         = id
//        self.company    = company
//        self.logo       = logo
//        self.model      = model
//        self.hight      = hight
//        self.width      = width
//        self.length     = length
//        self.height     = height
//        self.since      = since
//        self.end        = end
//        self.price      = price
//        self.kind       = kind
//        self.color      = color
//        self.selection  = selection
//        self.remarks    = remarks
//    }

