//
//  MonoViewController.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/10/23.
//  Copyright © 2019 小川響生. All rights reserved.
//

import UIKit

class MonoViewController: UIViewController {
    var MonoNum = 1
    @IBOutlet weak var monoName: UITextField!
    @IBOutlet weak var monoKazu: UITextField!
    @IBOutlet weak var monoDetail: UITextField!
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func CreateMono(_ sender: UIButton) {
        let kazu = Int(monoKazu.text!)
        let mono = Mono()
        mono.id = MonoNum
        mono.name = monoName.text!
        mono.kazu = kazu!
        mono.detail = monoDetail.text!
        let defaults = UserDefaults.standard
        let MonoId = String(MonoNum)
        let sendMono: NSData = NSKeyedArchiver.archivedData(withRootObject: mono) as NSData
        defaults.set(sendMono, forKey: MonoId)
        MonoNum += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
}
