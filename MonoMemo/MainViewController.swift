//
//  ViewController.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/10/22.
//  Copyright © 2019 小川響生. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let defaults = UserDefaults.standard
    @IBOutlet weak var monoTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let sectionData = tableData[section]
        return sectionData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
    }
    func numberOfSections(in tableView: UITableView) -> Int{
        return defaults.array(forKey: "sectionTitle")!.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return sectionTitle[section]
    }

    @IBAction func testAction(_ sender: Any){
        var count = defaults.integer(forKey: "Mononum")
         while (count > 0){
             let num = String(count)
             let data = defaults.object(forKey: num)
             let mono: Mono = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! Mono
            
             count -= 1
         }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        monoTableView.delegate = self
        monoTableView.dataSource = self
        //全てのsectionが入った配列tableDataを定義
        var tableData:[[String]] = []
        let sectionTitle = defaults.array(forKey: "sectionTitle") as! [String]
        for title in sectionTitle{
            let section = defaults.array(forKey: title) as! [String]
            tableData.append(section)
        }
    }
}

