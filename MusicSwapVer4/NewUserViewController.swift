//
//  NewUserViewController.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2016/12/17.
//  Copyright © 2016年 塗木冴. All rights reserved.
//

import UIKit
import RealmSwift

class NewUserViewController: UIViewController{

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    var profile = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSearchMusicView" {
            let name = nameLabel.text
            let password = passwordLabel.text
            self.profile.append(name!)
            self.profile.append(password!)
            let searchMusicViewController: SearchMusicViewController = segue.destination as! SearchMusicViewController
            searchMusicViewController.profile = self.profile
        } else {
            //適切なボタンでない対処法
        }
    }
    
}
