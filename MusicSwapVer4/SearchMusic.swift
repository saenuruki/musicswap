//
//  SearchMusic.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2016/12/08.
//  Copyright © 2016年 塗木冴. All rights reserved.
//

import Foundation
import RealmSwift

class SearchMusic: Object{
    
    dynamic var name:String = ""
    dynamic var artist:String = ""
    dynamic var imageUrl:String?
    //var status:Bool = false  いらない説ある
}
