//
//  MainViewController.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2016/12/21.
//  Copyright © 2016年 塗木冴. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController{
    
/*    var user:User?
    var myMusicArray = [MyMusic]()
    var myMusic:MyMusic?*/
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*let realm = try! Realm()
        self.user = realm.objects(User.self).last
        print(user!.myMusic)    //デバック用
        
        imageViewLoad(view: view1, count: 1)
        imageViewLoad(view: view2, count: 2)
        imageViewLoad(view: view3, count: 3)
        
        // タップを定義
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainViewController.viewTap(sender:count:)))
        
        // imageViewにタップを登録
        self.view1.addGestureRecognizer(tap)
        self.view2.addGestureRecognizer(tap)
        self.view3.addGestureRecognizer(tap)*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*func imageViewLoad(view: UIView,count: Int){
        let imageView = view.viewWithTag(count) as! UIImageView
        let url = URL(string: (user?.myMusic[count - 1].imageUrl)!)
        if let imageData = try? Data(contentsOf: url!){
            imageView.image = UIImage(data: imageData)
        }
    }
    
    //エラーの原因
    func viewTap(sender: UITapGestureRecognizer, count: Int){
        if user?.myMusic[count-1].status == "current"{
            user?.myMusic[count-1].status = "selected"
            //変更をrealmに保存する
            self.view.backgroundColor = UIColor.gray
            print("曲の再生状態 = \(user?.myMusic[count-1].status)")  //デバック用
        }
    }*/
    @IBAction func tapLogout(_ sender: Any) {
        logout()
    }
    
    func logout(){
        do{
            try FIRAuth.auth()?.signOut()   //do-try-catchの中で、FIRAuth.auth()?.signOut()を呼ぶだけで、ログアウトが完了
            let storyboard = UIStoryboard(name: "Login",bundle: nil) //storyboardを指定
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(loginViewController, animated: true, completion: nil)
        }catch let error as NSError {
            print("ログアウト失敗：\(error.localizedDescription)")
        }
    }
}
