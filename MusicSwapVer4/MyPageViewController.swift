//
//  MyPageViewController.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2017/01/01.
//  Copyright © 2017年 塗木冴. All rights reserved.
//

import UIKit
import Firebase

class MyPageViewController: UIViewController{

    var ref: FIRDatabaseReference!
    var myMusic:MyMusic?
    var myMusicArray = [MyMusic]()  //MyMusicリスト
    @IBOutlet weak var myMusic1: UIImageView!
    @IBOutlet weak var myMusic2: UIImageView!
    @IBOutlet weak var myMusic3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myMusicArray = []
        readFirebase()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapLogout(_ sender: Any) {
        logout()
    }
    
    func readFirebase(){
        ref = FIRDatabase.database().reference()
        let userId: String = (FIRAuth.auth()?.currentUser?.uid)!
        ref.child(userId).child("myMusic").observeSingleEvent(of: .value, with: { (snapshot) in
            self.myMusicArray.removeAll()
            var count:Int = 0
            for item in snapshot.children{
                let child = item as! FIRDataSnapshot
                let dic = child.value as! NSDictionary
                self.myMusic = MyMusic()
                self.myMusic?.name = dic["name"] as! String
                self.myMusic?.artist = dic["artist"] as! String
                self.myMusic?.imageUrl = dic["imageUrl"] as? String
                self.myMusic?.status = dic["status"] as! String
                self.myMusicArray.append(self.myMusic!)
                let url = URL(string: (self.myMusic?.imageUrl)!)
                if let imageData = try? Data(contentsOf: url!){
                    switch count{
                    case 0: self.myMusic1.image = UIImage(data: imageData)
                    case 1: self.myMusic2.image = UIImage(data: imageData)
                    case 2: self.myMusic3.image = UIImage(data: imageData)
                    default: break
                    }
                }
                count += 1
            }
        }) {(error) in
            print(error.localizedDescription)
        }
    }
    
    func logout(){
        do{
            try FIRAuth.auth()?.signOut()   //do-try-catchの中で、FIRAuth.auth()?.signOut()を呼ぶだけで、ログアウトが完了
            let storyboard = UIStoryboard(name: "Login",bundle: nil) //storyboardを指定
            let loginViewController = storyboard.instantiateInitialViewController()
            self.present(loginViewController!, animated: true, completion: nil)
        }catch let error as NSError {
            print("ログアウト失敗：\(error.localizedDescription)")
        }
    }
}
