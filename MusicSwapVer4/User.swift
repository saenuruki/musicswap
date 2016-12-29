//
//  User.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2016/12/17.
//  Copyright © 2016年 塗木冴. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object{
    
    
    dynamic var name:String = ""    //名前は重複していてかなわない
    dynamic var email:String = ""
    dynamic var password:String = ""    //暗号処理をする
    let myMusic = List<MyMusic>()
    /*override static func primaryKey() -> String? {    
     return "id"
     }*/
}

