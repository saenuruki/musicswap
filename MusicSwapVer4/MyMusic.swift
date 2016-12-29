//
//  MyMusic.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2016/12/21.
//  Copyright © 2016年 塗木冴. All rights reserved.
//

import Foundation
import RealmSwift

class MyMusic: Object{
    
    dynamic var id:Int = 0
    dynamic var name:String = ""
    dynamic var artist:String = ""
    dynamic var imageUrl:String?
    dynamic var status:String = ""//現在の3曲(current)と選択済(selected)と履歴(history)を識別する
    //dynamic var user:User?
}
