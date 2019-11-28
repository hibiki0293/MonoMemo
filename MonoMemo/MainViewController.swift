//
//  ViewController.swift
//  MonoMemo
//
//  Created by 小川響生 on 2019/10/22.
//  Copyright © 2019 小川響生. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var giveData:String = ""
    var searchActive:Bool = false
    var resultMonos:[String] = []//検索で使用
    let defaults = UserDefaults.standard
    @IBOutlet weak var monoTableView: UITableView!
    @IBOutlet weak var monoSearchBar: UISearchBar!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if searchActive{
            return resultMonos.count
        }else{
        let tableData = defaults.array(forKey: "tableData") as! [[String]]
        let sectionData = tableData[section]
        return sectionData.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "monoCell")
        if searchActive{
            cell?.textLabel?.text = resultMonos[indexPath.row]
        }else{
        let tableData = defaults.array(forKey: "tableData") as! [[String]]
        let sectionData = tableData[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell?.textLabel?.text = cellData
        }
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int{
        if searchActive{
            return 1
        }else{
        return defaults.array(forKey: "sectionTitle")?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        if searchActive{
            let searched = "検索結果"
            return searched
        }else{
        let sectionTitle = defaults.array(forKey: "sectionTitle") as! [String]
        return sectionTitle[section]
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table = defaults.array(forKey: "tableData") as! [[String]]
        giveData = table[indexPath.section][indexPath.row]
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        //押したら押した状態を解除
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    //スワイプで削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let table = defaults.array(forKey: "tableData") as! [[String]]
            let deleteMonoName = table[indexPath.section][indexPath.row]
            print(deleteMonoName)
            //monoの分類名を取得
            let data = defaults.object(forKey: deleteMonoName)
            let mono: Mono = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! Mono
            let sectionName = mono.affiliation
            let sectionKey = sectionName + "Section"
            //Monoそのものを削除
            defaults.removeObject(forKey: deleteMonoName)
            //nameListから該当する名前を削除し、更新
            var nameList = defaults.array(forKey: "nameList") as! [String]
            let deleteNameIndex = nameList.index(of: deleteMonoName) ?? 0
            nameList.remove(at: deleteNameIndex)
            defaults.set(nameList, forKey: "nameList")
            //該当するsectionから削除
            var section = defaults.array(forKey: sectionKey) as! [String]
            let deleteSectionIndex = section.index(of: deleteMonoName) ?? 0
            section.remove(at: deleteSectionIndex)
        //削除しするものに該当するsectionが空になる場合、そのsectionを削除する
            if section == []{
                defaults.removeObject(forKey: sectionKey)
                //sectionTitleからsection名を削除
                var sectionTitle = defaults.array(forKey: "sectionTitle") as! [String]
                let deleteTitleIndex = sectionTitle.index(of: sectionName) ?? 0
                sectionTitle.remove(at: deleteTitleIndex)
                defaults.set(sectionTitle, forKey: "sectionTitle")
            }else{
                defaults.set(section,forKey: sectionKey)
            }
            //反映
             loadTable()
            //sectionをtableviewから削除
            if section == []{
                let indexSet = NSMutableIndexSet()
                indexSet.add(indexPath.section)
                tableView.deleteSections(indexSet as IndexSet, with: UITableView.RowAnimation.automatic)
            }else{
                //cellを削除
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }


    @IBAction func testAction(_ sender: Any){
        //       一つ一つのMonoを取り出す処理
//        var count = defaults.integer(forKey: "Mononum")
//         while (count > 0){
//             let num = String(count)
//             let data = defaults.object(forKey: num)
//             let mono: Mono = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! Mono
//            print(mono.name)
//             count -= 1
//         }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        monoTableView.delegate = self
        monoTableView.dataSource = self
        monoSearchBar.delegate = self
        monoSearchBar.showsCancelButton = true
        loadTable()
    }
    
    func loadTable(){
        //全てのsectionが入った配列tableDataを定義、保存
              if defaults.array(forKey: "sectionTitle") != nil{
              var tableData:[[String]] = []
              let sectionTitle = defaults.array(forKey: "sectionTitle") as! [String]
              for title in sectionTitle{
                  let sectionKey = title + "Section"
                  let section = defaults.array(forKey: sectionKey) as! [String]
                  tableData.append(section)
              }
              defaults.set(tableData, forKey: "tableData")
          }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           //destinationのクラッシュ防ぐ
           if segue.identifier == "toDetail"{
               //detailViewControllerを取得
               //as! DetailViewControllerでダウンキャストしている
               let detailViewController = segue.destination as! DetailViewController
               //遷移前に選ばれているCellが取得できる
            detailViewController.selectedMonoName = giveData
           }
       }
    // 検索機能
    func searchMonos(searchText:String){
        if searchText.count != 0{
            searchActive = true
            let monos = defaults.array(forKey: "nameList") as! [String]
            resultMonos = monos.filter{mono in return mono.contains(searchText)}
            monoTableView.reloadData()
        }
    }
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         //検索する
         searchMonos(searchText: searchText)
     }
     //canselボタンが押されると呼ばれる
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

         monoSearchBar.text = ""
         self.view.endEditing(true)
         searchActive = false
         //tableViewを再読み込みする
         monoTableView.reloadData()
     }
     
     //Searchボタンが押されると呼ばれる
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         
         self.view.endEditing(true)
         //検索する
         searchMonos(searchText: monoSearchBar.text! as String)
     }
}

