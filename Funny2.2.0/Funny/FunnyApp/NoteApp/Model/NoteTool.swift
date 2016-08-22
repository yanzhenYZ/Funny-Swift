//
//  NoteTool.swift
//  Funny
//
//  Created by yanzhen on 16/1/20.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NoteTool: NSObject {
   
    /**      添加数据       */
    func addNewNoteItem(model: NoteModel) {
        var array = self.noteArrayOfFilePath();
        array?.append(model);
        NSKeyedArchiver.archiveRootObject(array!, toFile: NotePath);
    }
    
    /**      删除数据       */
    func deleteNoteItem(index: Int) {
        var array = self.noteArrayOfFilePath();
        array?.removeAtIndex(index);
        NSKeyedArchiver.archiveRootObject(array!, toFile: NotePath);
    }
    
    /**      修改数据       */
    func modifyNoteItem(index: Int, model: NoteModel) {
        var array = self.noteArrayOfFilePath();
        array?.removeAtIndex(index);
        array?.insert(model, atIndex: index);
        NSKeyedArchiver.archiveRootObject(array!, toFile: NotePath);
    }
    
    /**      加载数据       */
    func noteArrayOfFilePath() ->Array<AnyObject>? {
        var array = [NoteModel]();
        
        let exist = NSFileManager.defaultManager().fileExistsAtPath(NotePath);
        if exist {
            array = NSKeyedUnarchiver.unarchiveObjectWithFile(NotePath) as! Array<NoteModel>;
        }
        return array;
    }

}
let NoteHeaderPath = documentPath + "/note";
let NotePath = NoteHeaderPath + "/note.data";