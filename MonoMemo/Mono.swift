//
//  Mono.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/10/25.
//  Copyright © 2019 小川響生. All rights reserved.
//

import Foundation
class Mono: NSObject,NSCoding{
//    var id:Int
    var name = ""
    var kazu:Int
    var detail = ""
    var affiliation = ""
    
    init(_ name: String, _ kazu: Int, _ detail: String, _ affiliation: String){
//        self.id = id
        self.name = name
        self.kazu = kazu
        self.detail = detail
        self.affiliation = affiliation
    }
    
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.detail, forKey: "detail")
        aCoder.encode(self.kazu,forKey: "kazu")
        aCoder.encode(self.name,forKey: "name")
        aCoder.encode(self.affiliation, forKey: "affiliation")
}
    required init?(coder aDecoder: NSCoder) {
//        self.id = aDecoder.decodeInteger(forKey: "id")
        self.detail = aDecoder.decodeObject(forKey: "detail") as! String
        self.kazu = aDecoder.decodeInteger(forKey: "kazu")
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.affiliation = aDecoder.decodeObject(forKey: "affiliation") as! String
    }
}
