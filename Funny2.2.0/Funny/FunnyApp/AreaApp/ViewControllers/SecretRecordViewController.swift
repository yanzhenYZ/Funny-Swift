//
//  SecretRecordViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/7.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class SecretRecordViewController: SuperSecondViewController,UITableViewDataSource, UITableViewDelegate {
    
    var dataSource = [Array<AnyObject>]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false;
        
        let error: NSErrorPointer = nil;
        let exist = NSFileManager.defaultManager().fileExistsAtPath(SecretPathHeader);
        if !exist {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(SecretPathHeader, withIntermediateDirectories: true, attributes: nil)
            } catch let error1 as NSError {
                error.memory = error1
            };
        }
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.rightButtonAction));
        self.navigationItem.rightBarButtonItem = rightItem;
        
        self.tableView.registerNib(UINib(nibName: "SecretTableViewCell", bundle: nil), forCellReuseIdentifier: "SecretTableViewCell");
        self.loadData();
    }
    
    //MARK: - 加载数据
    func loadData() {
        if dataSource.count > 0 {
            self.dataSource.removeAll(keepCapacity: true);
        }
        for (index,_) in secretFilePathArray.enumerate() {
            let array = SecretTool().secretArrayOfFilePath(secretFilePathArray[index]);
            dataSource.append(array!);
        }
    }
    
    
    //MARK: - tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.count > section
        {
            let array = dataSource[section];
            return array.count;
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCellWithIdentifier("SecretTableViewCell", forIndexPath: indexPath) as! SecretTableViewCell;
        let array = dataSource[indexPath.section];
        cell.model = array[indexPath.row] as! SecretModel;
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longGestureAction(_:)));
        cell.addGestureRecognizer(longGesture);
        return cell;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secretTitleArray[section];
    }
    
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = SecretNewItemViewController(nibName: "SecretNewItemViewController", bundle: nil);
        vc.recordVC = self;
        vc.indexPath = indexPath;
        var array = dataSource[indexPath.section];
        vc.model = array[indexPath.row] as! SecretModel;
        vc.isModify = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.deleteItem(indexPath);
        }
    }
    
    //MARK: - Add Delete Modify
    func addNewItem(index: Int, model: SecretModel) {
        SecretTool().addNewSecretItem(secretFilePathArray[index], model: model);
        
        var array = dataSource[index];
        array.append(model);
        dataSource.removeAtIndex(index);
        dataSource.insert(array, atIndex: index);
        tableView.reloadData();
    }
    
    func deleteItem(indexPath: NSIndexPath) {
        SecretTool().deleteSecretItem(secretFilePathArray[indexPath.section], index: indexPath.row);
        
        var array = dataSource[indexPath.section];
        array.removeAtIndex(indexPath.row);
        dataSource.removeAtIndex(indexPath.section);
        dataSource.insert(array, atIndex: indexPath.section);
        tableView.reloadData();
        
    }
    
    func modifyItem(indexPath: NSIndexPath, model: SecretModel) {
        SecretTool().modifySecretItem(secretFilePathArray[indexPath.section], index: indexPath.row, model: model);
        
        var array = dataSource[indexPath.section];
        array.removeAtIndex(indexPath.row);
        array.insert(model, atIndex: indexPath.row);
        dataSource.removeAtIndex(indexPath.section);
        dataSource.insert(array, atIndex: indexPath.section);
        tableView.reloadData();
    }
    
    //MARK: - action
    func rightButtonAction() {
        let vc = SecretNewItemViewController(nibName: "SecretNewItemViewController", bundle: nil);
        vc.recordVC = self;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func longGestureAction(longGesture: UILongPressGestureRecognizer) {
        if longGesture.state != UIGestureRecognizerState.Began{
            return;
        }
        self.tableView.editing = !self.tableView.editing;
    }
    
}
