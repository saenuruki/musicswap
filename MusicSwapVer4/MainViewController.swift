//
//  MainViewController.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2016/12/21.
//  Copyright © 2016年 塗木冴. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController{
    
    var user:User?
    var myMusicArray = [MyMusic]()
    var myMusic:MyMusic?
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        self.user = realm.objects(User.self).last
        print(user!.myMusic)    //デバック用
        
        imageViewLoad(view: view1, count: 1)
        imageViewLoad(view: view2, count: 2)
        imageViewLoad(view: view3, count: 3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imageViewLoad(view: UIView,count: Int){
        let imageView = view.viewWithTag(count) as! UIImageView
        let url = URL(string: (user?.myMusic[count - 1].imageUrl)!)
        if let imageData = try? Data(contentsOf: url!){
            imageView.image = UIImage(data: imageData)
        }
    }
    
}
