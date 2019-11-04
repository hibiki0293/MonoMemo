//
//  MonoViewController.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/10/23.
//  Copyright © 2019 小川響生. All rights reserved.
//

import UIKit
var MonoNum = 1
var sectionTitle:[String] = [] //mainViewのテーブルで使用
class MonoViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var monoName: UITextField!
    @IBOutlet weak var monoKazu: UITextField!
    @IBOutlet weak var monoDetail: UITextField!
    @IBOutlet weak var monoAffiliation: UITextField!
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func CreateMono(_ sender: UIButton) {
        if MonoNum != 1{
        MonoNum = defaults.integer(forKey: "Mononum")
        }
        let kazu = Int(monoKazu.text!)
        let mono = Mono(MonoNum, monoName.text!, kazu!, monoDetail.text!, monoAffiliation.text!)
        let MonoId = String(MonoNum)
        let sendMono = try! NSKeyedArchiver.archivedData(withRootObject: mono, requiringSecureCoding: false)
        defaults.set(sendMono, forKey: MonoId)
        MonoNum += 1
        let IndexNo = sectionTitle.index(of: monoAffiliation.text!)
        if IndexNo == nil{
            sectionTitle.append(monoAffiliation.text!)
        }
        defaults.set(sectionTitle, forKey: "sectionTitle")
        defaults.set(MonoNum, forKey: "Mononum") //登録されたものの個数をKey:"Mononum"で保存
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
}
