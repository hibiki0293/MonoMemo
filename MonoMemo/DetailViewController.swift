//
//  DetailViewController.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/11/10.
//  Copyright © 2019 小川響生. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    var selectedMonoName:String = ""
    let defaults = UserDefaults.standard
    @IBOutlet weak var monoName: UILabel!
    @IBOutlet weak var monoKazu: UILabel!
    @IBOutlet weak var monoDetail: UILabel!
    @IBOutlet weak var monoAffiliation: UILabel!
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        let data = defaults.object(forKey: selectedMonoName)
        let mono: Mono = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! Mono
        monoName.text = mono.name
        monoKazu.text = String(mono.kazu)
        monoDetail.text = mono.detail
        monoAffiliation.text = mono.affiliation
    }
}
