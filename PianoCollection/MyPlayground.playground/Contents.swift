//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var pianotest:String = "test piano"

var piano: String {
    return "yourpiano"
}

print(pianotest)
print(piano)


//let  letnames:Array = UIFont.familyNames
//print(letnames)
//
//var names:Array = UIFont.familyNames
//print(names.debugDescription)
//var rem = names.remove(at: 0)
//print(names)
//print(rem)

/**
lazy var pianos:[String] = {
    return UIFont.familyNames
} ()
 */

class Hello:NSObject {
    lazy var str:String = {
        return "hello class"
    } ()
    
    lazy var pianos:[String] = {
        return UIFont.familyNames
    }()
    
    
    override init() {
        super.init()
        print(str)
        print(pianos)
    }
    
    
    
}










