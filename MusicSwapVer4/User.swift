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
    
    var name:String = ""
    var password:String = ""
    //var myMusic:[MyMusic] = []//3曲格納する配列
    
    /*func addMyMusic(selectedMusic: SearchMusic){
        myMusic?.name = selectedMusic.name
        self.myMusic.artist = selectedMusic.artist
    }*/
    
}

