//
//  SearchMusicViewController.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2016/12/17.
//  Copyright © 2016年 塗木冴. All rights reserved.
//

import UIKit
import RealmSwift

class SearchMusicViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{
    
    //prepareForSegueメソッドより引き継いだ情報を取得する
    var profile = [String]()
    var user:User?
    var nextButton: UIButton!
    var searchMusicArray = [SearchMusic]()
    var searchMusic:SearchMusic?
    var selectedMusicArray = [SearchMusic]()  //選択済の曲リスト
    let mySections = ["選択された曲","検索結果"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("user.name = \(profile[0])")    //デバック用
        print("user.password = \(profile[1])")//デバック用
        
        // Do any additional setup after loading the view, typically from a nib.
        searchText.delegate = self  //searchBarの通知先を指定
        searchText.placeholder = "検索キーワードを入力してください"
        tableView.dataSource = self //tableViewのデータ・ソースを設定
        self.selectedMusicArray = []
        
        //遷移ボタン生成  ※理解不十分 間違いの可能性あり
        nextButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        nextButton.backgroundColor = UIColor.red
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height-50)
        nextButton.setTitle("登録する", for: .normal)
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.addTarget(self, action: #selector(SearchMusicViewController.onClickNextButton(sender:)), for: .touchUpInside)
        nextButton.isHidden = true
        self.view.addSubview(nextButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)   //キーボードを閉じる
        print("searchBar.text = \(searchBar.text!)")   //デバック用
        if let searchWord = searchBar.text {
            search(keyword: searchWord)
        }
    }
    
    func search(keyword: String){
        self.searchMusicArray = []
        let keywordEncode = keyword.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)  //検索キーワードをurlエンコードする
        let url = Foundation.URL(string: "http://itunes.apple.com/search?term=\(keywordEncode!)&country=jp&media=music")    //URLオブジェクトを生成
        print("url = \(url!)")  //デバック用
        
        let req = URLRequest(url: url!) //リクエストオブジェクト生成
        let configuration = URLSessionConfiguration.default    //セッション接続をデフォルト指定
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)    //セッション情報の取り出し
        let task = session.dataTask(with: req, completionHandler: { //リクエストをタスクとして登録
            (data, request, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any] //wifiの都合で取得が出来ないことあるかも！テザリングなら可
                //もしここでエラーが出たら、3冊目「これから作るiPhoneアプリ」のp359を確認
                self.searchMusicArray.removeAll()
                if let results = json["results"] as? [[String:Any]] {   //曲情報が取得出来ているかの確認
                    let resultCount: Int = (json["resultCount"] as? Int)!
                    for count in 0..<resultCount{
                        let result = results[count]
                        guard let name = result["trackName"] as? String else {continue}
                        guard let artist = result["artistName"] as? String else {continue}
                        guard let imageUrl = result["artworkUrl60"] as? String else {continue}
                        self.searchMusic = SearchMusic()
                        self.searchMusic?.name = name
                        self.searchMusic?.artist = artist
                        self.searchMusic?.imageUrl = imageUrl
                        self.searchMusicArray.append(self.searchMusic!)
                    }
                }
                self.tableView.reloadData()
            } catch {
                print("エラーです")
            }
        })
        task.resume()
    }
    
    //セクションの数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    
    //テーブルに表示する配列の数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return selectedMusicArray.count
        } else if section == 1 {
            return searchMusicArray.count
        } else{
            return 0
        }
    }
    
    //セクションのタイトルを返す
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section]
    }
    
    //セルに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchMusicCell", for: indexPath)
        if indexPath.section == 0 {
            let nameLabel = tableView.viewWithTag(2) as! UILabel
            nameLabel.text = selectedMusicArray[indexPath.row].name
            let artistLabel = tableView.viewWithTag(3) as! UILabel
            artistLabel.text = selectedMusicArray[indexPath.row].artist
            let imageView = tableView.viewWithTag(1) as! UIImageView
            let url = URL(string: selectedMusicArray[indexPath.row].imageUrl!)
            if let imageData = try? Data(contentsOf: url!){
                imageView.image = UIImage(data:imageData)
            }
        } else if indexPath.section == 1 {
            let nameLabel = tableView.viewWithTag(2) as! UILabel
            nameLabel.text = searchMusicArray[indexPath.row].name
            let artistLabel = tableView.viewWithTag(3) as! UILabel
            artistLabel.text = searchMusicArray[indexPath.row].artist
            let imageView = tableView.viewWithTag(1) as! UIImageView
            let url = URL(string: searchMusicArray[indexPath.row].imageUrl!)
            if let imageData = try? Data(contentsOf: url!){
                imageView.image = UIImage(data:imageData)
            }
        }
        return cell
    }
    
    //タップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("「\(searchMusicArray[indexPath.row].name)」 が選択されました") //デバック用
        //selectedMusicArrayに追加する
        if selectedMusicArray.count == 2 {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
        if selectedMusicArray.count < 3 {
            selectedMusicArray.append(searchMusicArray[indexPath.row])
            self.tableView.reloadData()
        }
        
    }
    
    //セル削除処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedMusicArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
   internal func onClickNextButton(sender: UIButton){
       
        let storyboard = UIStoryboard(name: "Main",bundle: nil) //storyboardを指定
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        self.present(mainViewController, animated: true, completion: nil)
    
        
        /*
         selectedMusicArrayの中身をUserクラスの3曲配列に取得する
         self.user?.myThreeMusic = selectedMusicArray⇒恐らくfor文で一つずつ代入
         let realm = try! Realm()
         try! realm.write {
            realm.add(self.user!)
         }
         */
    }
    
    //ページ遷移する最後にcurrentuserにUser.nameを代入する
}
