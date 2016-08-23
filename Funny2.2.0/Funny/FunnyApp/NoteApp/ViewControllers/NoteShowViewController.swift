//
//  NoteShowViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class NoteShowViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,NoteCellProtocol{

    private var dataSource = [NoteModel]()
    private var collectionView: UICollectionView!
    private var isEdit: Bool = false;
    private var itemBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI();
        let array = NoteTool().noteArrayOfFilePath();
        if array?.count > 0 {
            for (_,value) in array!.enumerate() {
                let model = value as! NoteModel;
                dataSource.append(model);
            }
        }
    }

    @IBAction func addNewItem(sender: AnyObject) {
        let vc = NoteWriteViewController(nibName: "NoteWriteViewController", bundle: nil);
        vc.noteShowVC = self;
        self.navigationController?.pushViewController(vc, animated: true);
    }
//MARK: - collectionView
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NoteCell", forIndexPath: indexPath) as! NoteCollectionViewCell;
        let model = dataSource[indexPath.item];
        cell.model = model;
        cell.delegate = self;
        cell.deleteBtn.hidden = !isEdit;
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !isEdit {
            self.goToModifyItem(indexPath);
        }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(WIDTH / 2 - 15, 170);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 8, 10, 8);
    }
    //MARK: - item
    func addNewItemToShowVC(model: NoteModel) {
        NoteTool().addNewNoteItem(model);
        self.dataSource.append(model);
        collectionView.reloadData();
    }
    
    func modifyItem(indexPath: NSIndexPath, model: NoteModel) {
        NoteTool().modifyNoteItem(indexPath.item, model: model);
        self.dataSource.removeAtIndex(indexPath.item);
        self.dataSource.insert(model, atIndex: indexPath.item);
        collectionView.reloadData();
    }
    
    
//MARK: - cell delegate 
    
    func modifyNote(noteCell: NoteCollectionViewCell) {
        let indexPath = collectionView.indexPathForCell(noteCell);
        self.goToModifyItem(indexPath!);
    }
    
    func deleteNote(noteCell: NoteCollectionViewCell) {
        let indexPath = collectionView.indexPathForCell(noteCell);
        NoteTool().deleteNoteItem(indexPath!.item);
        dataSource.removeAtIndex(indexPath!.item);
        collectionView.reloadData();
    }
    
    func goToModifyItem(indexPath: NSIndexPath) {
        let model = dataSource[indexPath.item];
        let vc = NoteWriteViewController(nibName: "NoteWriteViewController", bundle: nil);
        vc.noteShowVC = self;
        vc.isModify = true;
        vc.noteModel = model;
        vc.indexPath = indexPath;
        self.navigationController?.pushViewController(vc, animated: true);
    }
//MARK: - UI
    private func configUI() {
        self.title = "Note Manage";
        let error: NSErrorPointer = nil;
        let exist = NSFileManager.defaultManager().fileExistsAtPath(NoteHeaderPath);
        if !exist {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(NoteHeaderPath, withIntermediateDirectories: true, attributes: nil);
            } catch let error1 as NSError {
                error.memory = error1
            };
            
        }

        itemBtn = UIButton(frame: CGRectMake(0, 0, 40, 40));
        itemBtn.setTitle("编辑", forState: UIControlState.Normal);
        itemBtn.setTitleColor(FunnyManager.manager.color(0.0, G: 99.0, B: 251.0), forState: UIControlState.Normal);
        itemBtn.addTarget(self, action: #selector(self.editButtonClick), forControlEvents: UIControlEvents.TouchUpInside);
        let rightItem = UIBarButtonItem(customView: itemBtn);
        self.navigationItem.rightBarButtonItem = rightItem;
        
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical;
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 10;
        
        collectionView = UICollectionView(frame: CGRectMake(0, 64, WIDTH, HEIGHT-64-44), collectionViewLayout: flowLayout);
        collectionView.backgroundColor = FunnyManager.manager.color(200.0, G: 200.0, B: 200.0);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.view.addSubview(collectionView);
        collectionView.registerNib(UINib(nibName: "NoteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoteCell");
    }
    
    func editButtonClick() {
        if itemBtn.titleLabel?.text == "编辑" {
            isEdit = true;
            itemBtn.setTitle("完成", forState: UIControlState.Normal);
        }else{
            isEdit = false;
            itemBtn.setTitle("编辑", forState: UIControlState.Normal);
        }
        collectionView.reloadData();
    }
}
