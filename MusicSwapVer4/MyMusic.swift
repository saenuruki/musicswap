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
    
    var name:String = ""
    var artist:String = ""
    var imageUrl:String?
    var status:String = ""//現在の3曲(current)と履歴(history)を識別する
}
