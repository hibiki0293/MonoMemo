//
//  ViewController.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/10/22.
//  Copyright © 2019 小川響生. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBAction func testAction(_ sender: Any){
        var count = monos.count
         while (count > 0){
             let num = String(count)
             let data = UserDefaults.standard.object(forKey: num)
             let mono: Mono = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! Mono
             print(mono.name)
             count -= 1
         }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

