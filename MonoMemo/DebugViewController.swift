//
//  DebugViewController.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/11/21.
//  Copyright © 2019 小川響生. All rights reserved.
//

import UIKit
class DebugViewController: UIViewController{
    let defaults = UserDefaults.standard
    @IBAction func deleteUserdefaults(_ sender: Any) {
                //userdefaultsを全て削除
                let appDomain = Bundle.main.bundleIdentifier
                defaults.removePersistentDomain(forName: appDomain!)

    }
    @IBAction func confirm(_ sender: Any) {
        //tableの中身を確認
        let table = defaults.array(forKey: "tableData") as! [[String]]
        let title = defaults.array(forKey: "sectionTitle") as! [String]
        let names = defaults.array(forKey: "nameList") as! [String]
        print(table)
        print(title)
        print(names)
    }
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
    }
}
