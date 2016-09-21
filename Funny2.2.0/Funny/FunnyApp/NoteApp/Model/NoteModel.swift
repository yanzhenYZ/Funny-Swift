//
//  NoteModel.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NoteModel: NSObject,NSCoding {
   
    var noteTitle: String!
    var noteTime: String!
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(noteTitle, forKey: NOTETITLE);
        aCoder.encode(noteTime, forKey: NOTETIME);
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init();
        noteTitle = aDecoder.decodeObject(forKey: NOTETITLE) as! String;
        noteTime = aDecoder.decodeObject(forKey: NOTETIME) as! String;
    }
    
    override init() {
        
    }

}

let NOTETIME = "noteTime"
let NOTETITLE = "noteTitle";
