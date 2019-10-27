//
//  Mono.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/10/25.
//  Copyright © 2019 小川響生. All rights reserved.
//

import Foundation
class Mono: NSObject,NSCoding{
    var id:Int
    var name = ""
    var kazu:Int
    var detail = ""
    
    init(_ id: Int, _ name: String, _ kazu: Int, _ detail: String){
        self.id = id
        self.name = name
        self.kazu = kazu
        self.detail = detail
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.detail, forKey: "detail")
        aCoder.encode(self.kazu,forKey: "kazu")
        aCoder.encode(self.name,forKey: "name")
}
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as! Int
        detail = aDecoder.decodeObject(forKey: "detail") as! String
        kazu = aDecoder.decodeObject(forKey: "kazu") as! Int
        name = aDecoder.decodeObject(forKey: "name") as! String
    }
}
