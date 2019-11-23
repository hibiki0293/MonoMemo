//
//  MonoViewController.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/10/23.
//  Copyright © 2019 小川響生. All rights reserved.
//

import UIKit
var MonoNum = 1 //Monoの総数
var sectionTitle:[String] = [] //sectionのタイトルを入れるテーブル
var nameList:[String] = [] //monoのnameList

class MonoViewController: UIViewController {


    var alertController: UIAlertController!
    let defaults = UserDefaults.standard
    @IBOutlet weak var monoName: UITextField!
    @IBOutlet weak var monoKazu: UITextField!
    @IBOutlet weak var monoDetail: UITextField!
    @IBOutlet weak var monoAffiliation: UITextField!
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func CreateMono(_ sender: UIButton) {

        let kazu = Int(monoKazu.text!)
        let mono = Mono(monoName.text!, kazu!, monoDetail.text!, monoAffiliation.text!)
//        let MonoId = String(MonoNum)
        let sendMono = try! NSKeyedArchiver.archivedData(withRootObject: mono, requiringSecureCoding: false)
        defaults.set(sendMono, forKey: monoName.text!)
        MonoNum += 1
       
         //名前が被らないように、nameListに名前が入っていないか確認
        let nameIndexNo = nameList.index(of: monoName.text!)
        if nameIndexNo != nil{
            alert(title: "既に使用されている名前です",message: "名前を変更してください")
        }else{
            nameList.append(monoName.text!)
            defaults.set(nameList, forKey: "nameList")//nameListを保存
            //配列sectionTitle中に、monoAffiliationがなかった場合は新たにkey:affiliationのsectionを作り、あった場合は既存のsectionを読み込みappendし、上書き保存する。
            let titleIndexNo = sectionTitle.index(of: monoAffiliation.text!)
            if titleIndexNo == nil{
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
            alert(title: "保存が完了しました", message: "")
        }
       

       
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //mono登録が2回目以降の場合、以下３つの値を取得
        if defaults.array(forKey: "nameList") != nil{
        MonoNum = defaults.integer(forKey: "Mononum")
        nameList = defaults.array(forKey: "nameList") as! [String]
        sectionTitle = defaults.array(forKey: "sectionTitle") as! [String]
        }
        
    }
    func alert(title:String, message:String) {
           alertController = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
           present(alertController, animated: true)
       }
}
