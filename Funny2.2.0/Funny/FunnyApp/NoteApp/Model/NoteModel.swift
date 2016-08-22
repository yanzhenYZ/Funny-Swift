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
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(noteTitle, forKey: NOTETITLE);
        aCoder.encodeObject(noteTime, forKey: NOTETIME);
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init();
        noteTitle = aDecoder.decodeObjectForKey(NOTETITLE) as! String;
        noteTime = aDecoder.decodeObjectForKey(NOTETIME) as! String;
    }
    
    override init() {
        
    }

}

let NOTETIME = "noteTime"
let NOTETITLE = "noteTitle";
