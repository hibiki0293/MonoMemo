//
//  ViewController.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/10/22.
//  Copyright © 2019 小川響生. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var monoTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return UserDefaults.standard.integer(forKey: "Mononum")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
    }
    func numberOfSections(in tableView: UITableView) -> Int{
        return UserDefaults.standard.array(forKey: "sectionTitle")!.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
    }

    @IBAction func testAction(_ sender: Any){
        var count = UserDefaults.standard.integer(forKey: "Mononum")
         while (count > 0){
             let num = String(count)
             let data = UserDefaults.standard.object(forKey: num)
             let mono: Mono = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! Mono
            
             count -= 1
         }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        monoTableView.delegate = self
        monoTableView.dataSource = self
    }
}

