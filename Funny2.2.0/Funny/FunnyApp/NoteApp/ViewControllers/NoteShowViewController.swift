//
//  NoteShowViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class NoteShowViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,NoteCellProtocol{

    fileprivate var dataSource = [NoteModel]()
    fileprivate var collectionView: UICollectionView!
    fileprivate var isEdit: Bool = false;
    fileprivate var itemBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI();
        let array = NoteTool().noteArrayOfFilePath();
        if array?.count > 0 {
            for (_,value) in array!.enumerated() {
                let model = value as! NoteModel;
                dataSource.append(model);
            }
        }
    }

    @IBAction func addNewItem(_ sender: AnyObject) {
        let vc = NoteWriteViewController(nibName: "NoteWriteViewController", bundle: nil);
        vc.noteShowVC = self;
        self.navigationController?.pushViewController(vc, animated: true);
    }
//MARK: - collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCollectionViewCell;
        let model = dataSource[(indexPath as NSIndexPath).item];
        cell.model = model;
        cell.delegate = self;
        cell.deleteBtn.isHidden = !isEdit;
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEdit {
            self.goToModifyItem(indexPath);
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: WIDTH / 2 - 15, height: 170);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 8, 10, 8);
    }
    //MARK: - item
    func addNewItemToShowVC(_ model: NoteModel) {
        NoteTool().addNewNoteItem(model);
        self.dataSource.append(model);
        collectionView.reloadData();
    }
    
    func modifyItem(_ indexPath: IndexPath, model: NoteModel) {
        NoteTool().modifyNoteItem((indexPath as NSIndexPath).item, model: model);
        self.dataSource.remove(at: (indexPath as NSIndexPath).item);
        self.dataSource.insert(model, at: (indexPath as NSIndexPath).item);
        collectionView.reloadData();
    }
    
    
//MARK: - cell delegate 
    
    func modifyNote(_ noteCell: NoteCollectionViewCell) {
        let indexPath = collectionView.indexPath(for: noteCell);
        self.goToModifyItem(indexPath!);
    }
    
    func deleteNote(_ noteCell: NoteCollectionViewCell) {
        let indexPath = collectionView.indexPath(for: noteCell);
        NoteTool().deleteNoteItem((indexPath! as NSIndexPath).item);
        dataSource.remove(at: (indexPath! as NSIndexPath).item);
        collectionView.reloadData();
    }
    
    func goToModifyItem(_ indexPath: IndexPath) {
        let model = dataSource[(indexPath as NSIndexPath).item];
        let vc = NoteWriteViewController(nibName: "NoteWriteViewController", bundle: nil);
        vc.noteShowVC = self;
        vc.isModify = true;
        vc.noteModel = model;
        vc.indexPath = indexPath;
        self.navigationController?.pushViewController(vc, animated: true);
    }
//MARK: - UI
    fileprivate func configUI() {
        self.title = "Note Manage";
        let error: NSErrorPointer? = nil;
        let exist = FileManager.default.fileExists(atPath: NoteHeaderPath);
        if !exist {
            do {
                try FileManager.default.createDirectory(atPath: NoteHeaderPath, withIntermediateDirectories: true, attributes: nil);
            } catch let error1 as NSError {
                error??.pointee = error1
            };
            
        }

        itemBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40));
        itemBtn.setTitle("编辑", for: UIControlState());
        itemBtn.setTitleColor(FunnyManager.manager.color(0.0, G: 99.0, B: 251.0), for: UIControlState());
        itemBtn.addTarget(self, action: #selector(self.editButtonClick), for: UIControlEvents.touchUpInside);
        let rightItem = UIBarButtonItem(customView: itemBtn);
        self.navigationItem.rightBarButtonItem = rightItem;
        
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical;
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 10;
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 64, width: WIDTH, height: HEIGHT-64-44), collectionViewLayout: flowLayout);
        collectionView.backgroundColor = FunnyManager.manager.color(200.0, G: 200.0, B: 200.0);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.view.addSubview(collectionView);
        collectionView.register(UINib(nibName: "NoteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoteCell");
    }
    
    func editButtonClick() {
        if itemBtn.titleLabel?.text == "编辑" {
            isEdit = true;
            itemBtn.setTitle("完成", for: UIControlState());
        }else{
            isEdit = false;
            itemBtn.setTitle("编辑", for: UIControlState());
        }
        collectionView.reloadData();
    }
}
