//
//  MonoViewController.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/10/23.
//  Copyright © 2019 小川響生. All rights reserved.
//

import UIKit
var MonoNum = 1
//var tableData:[String] = [] //sectionのまとまりを入れるテーブル
var sectionTitle:[String] = [] //sectionのタイトルを入れるテーブル
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
        //mono登録が2回目以降の場合、以下３つの値を取得
        if MonoNum != 1{
        MonoNum = defaults.integer(forKey: "Mononum")
//            tableData = defaults.array(forKey: "tableData") as! [String]
            sectionTitle = defaults.array(forKey: "sectionTitle") as! [String]
        }
        let kazu = Int(monoKazu.text!)
        let mono = Mono(MonoNum, monoName.text!, kazu!, monoDetail.text!, monoAffiliation.text!)
        let MonoId = String(MonoNum)
        let sendMono = try! NSKeyedArchiver.archivedData(withRootObject: mono, requiringSecureCoding: false)
        defaults.set(sendMono, forKey: MonoId)
        MonoNum += 1
        let IndexNo = sectionTitle.index(of: monoAffiliation.text!)
        // 配列sectionTitle中に、monoAffiliationがなかった場合は新たにkey:affiliationのsectionを作り、あった場合は既存のsectionを読み込みappendし、上書き保存する。
        if IndexNo == nil{
            sectionTitle.append(monoAffiliation.text!)
            let section = [mono.name]
            defaults.set(section, forKey: monoAffiliation.text!)
        }else{
            var section:[String] = defaults.array(forKey: monoAffiliation.text!) as! [String]
            section.append(monoName.text!)
            defaults.set(section, forKey: monoAffiliation.text!)
        }
        defaults.set(sectionTitle, forKey: "sectionTitle")//sectionのタイトル（affiliation)の配列を保存
        defaults.set(MonoNum, forKey: "Mononum") //登録されたものの個数をKey:"Mononum"で保存
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
}
