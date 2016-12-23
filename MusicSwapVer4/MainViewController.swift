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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        let user = realm.objects(User.self).filter("name contains 'sae'")
        print("user.name = \(user)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
