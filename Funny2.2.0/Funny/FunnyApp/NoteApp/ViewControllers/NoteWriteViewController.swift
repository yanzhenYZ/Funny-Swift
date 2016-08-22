//
//  NoteWriteViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NoteWriteViewController: UIViewController {

    var noteShowVC: NoteShowViewController!
    var isModify: Bool = false
    var indexPath: NSIndexPath!
    var noteModel: NoteModel!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Note";
        if isModify {
            textView.text = noteModel.noteTitle;
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.saveButtonClick));
        self.textView.becomeFirstResponder();
    }

    func saveButtonClick() {
        if textView.text.isEmpty {
            self.view.makeCenterToast("内容为空,请重新输入");
        }else{
            let model = NoteModel();
            model.noteTitle = textView.text;
            if isModify {
                model.noteTime = noteModel.noteTime;
                noteShowVC.modifyItem(indexPath, model: model);
            }else{
                model.noteTime = self.noteTimeString();
                noteShowVC.addNewItemToShowVC(model);
            }
            self.navigationController?.popViewControllerAnimated(true);
        }
    }
    
    private func noteTimeString() ->String {
        let format = NSDateFormatter();
        format.dateFormat = "dd/MM HH:mm";
        return format.stringFromDate(NSDate());
    }
    
}
