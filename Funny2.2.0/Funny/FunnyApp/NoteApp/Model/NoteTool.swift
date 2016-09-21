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
    func addNewNoteItem(_ model: NoteModel) {
        var array = self.noteArrayOfFilePath();
        array?.append(model);
        NSKeyedArchiver.archiveRootObject(array!, toFile: NotePath);
    }
    
    /**      删除数据       */
    func deleteNoteItem(_ index: Int) {
        var array = self.noteArrayOfFilePath();
        array?.remove(at: index);
        NSKeyedArchiver.archiveRootObject(array!, toFile: NotePath);
    }
    
    /**      修改数据       */
    func modifyNoteItem(_ index: Int, model: NoteModel) {
        var array = self.noteArrayOfFilePath();
        array?.remove(at: index);
        array?.insert(model, at: index);
        NSKeyedArchiver.archiveRootObject(array!, toFile: NotePath);
    }
    
    /**      加载数据       */
    func noteArrayOfFilePath() ->Array<AnyObject>? {
        var array = [NoteModel]();
        
        let exist = FileManager.default.fileExists(atPath: NotePath);
        if exist {
            array = NSKeyedUnarchiver.unarchiveObject(withFile: NotePath) as! Array<NoteModel>;
        }
        return array;
    }

}
let NoteHeaderPath = documentPath + "/note";
let NotePath = NoteHeaderPath + "/note.data";
