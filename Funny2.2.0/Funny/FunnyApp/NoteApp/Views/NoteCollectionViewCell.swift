//
//  NoteCollectionViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

protocol NoteCellProtocol : NSObjectProtocol{
    func modifyNote(noteCell: NoteCollectionViewCell)
    func deleteNote(noteCell: NoteCollectionViewCell)
}
class NoteCollectionViewCell: UICollectionViewCell {

    weak var delegate: NoteCellProtocol?
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var deleteBtn: UIButton!
    var model: NoteModel! {
        didSet{
            textView.text = model.noteTitle;
            timeLabel.text = model.noteTime;
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)));
        self.textView.addGestureRecognizer(tap);
    }

    @IBAction func deleteBtnClick(sender: UIButton) {
        //可以把自己传过去
        delegate?.deleteNote(self);
    }
    
    func tapAction(tap: UITapGestureRecognizer) {
        delegate?.modifyNote(self);
    }
}
