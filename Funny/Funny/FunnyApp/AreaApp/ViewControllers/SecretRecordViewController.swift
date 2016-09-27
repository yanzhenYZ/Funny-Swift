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
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let error: NSErrorPointer? = nil;
        let exist = FileManager.default.fileExists(atPath: SecretPathHeader);
        if !exist {
            do {
                try FileManager.default.createDirectory(atPath: SecretPathHeader, withIntermediateDirectories: true, attributes: nil)
            } catch let error1 as NSError {
                error??.pointee = error1
            };
        }
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.rightButtonAction));
        self.navigationItem.rightBarButtonItem = rightItem;
        
        self.tableView.register(UINib(nibName: "SecretTableViewCell", bundle: nil), forCellReuseIdentifier: "SecretTableViewCell");
        self.loadData();
    }
    
    //MARK: - 加载数据
    func loadData() {
        if dataSource.count > 0 {
            self.dataSource.removeAll(keepingCapacity: true);
        }
        for (index,_) in secretFilePathArray.enumerated() {
            let array = SecretTool().secretArrayOfFilePath(secretFilePathArray[index]);
            dataSource.append(array!);
        }
    }
    
    
    //MARK: - tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.count > section
        {
            let array = dataSource[section];
            return array.count;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "SecretTableViewCell", for: indexPath) as! SecretTableViewCell;
        let array = dataSource[(indexPath as NSIndexPath).section];
        cell.model = array[indexPath.row] as! SecretModel;
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longGestureAction(_:)));
        cell.addGestureRecognizer(longGesture);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secretTitleArray[section];
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecretNewItemViewController(nibName: "SecretNewItemViewController", bundle: nil);
        vc.recordVC = self;
        vc.indexPath = indexPath;
        var array = dataSource[(indexPath as NSIndexPath).section];
        vc.model = array[indexPath.row] as! SecretModel;
        vc.isModify = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.deleteItem(indexPath);
        }
    }
    
    //MARK: - Add Delete Modify
    func addNewItem(_ index: Int, model: SecretModel) {
        SecretTool().addNewSecretItem(secretFilePathArray[index], model: model);
        
        var array = dataSource[index];
        array.append(model);
        dataSource.remove(at: index);
        dataSource.insert(array, at: index);
        tableView.reloadData();
    }
    
    func deleteItem(_ indexPath: IndexPath) {
        SecretTool().deleteSecretItem(secretFilePathArray[(indexPath as NSIndexPath).section], index: indexPath.row);
        
        var array = dataSource[(indexPath as NSIndexPath).section];
        array.remove(at: indexPath.row);
        dataSource.remove(at: (indexPath as NSIndexPath).section);
        dataSource.insert(array, at: (indexPath as NSIndexPath).section);
        tableView.reloadData();
        
    }
    
    func modifyItem(_ indexPath: IndexPath, model: SecretModel) {
        SecretTool().modifySecretItem(secretFilePathArray[(indexPath as NSIndexPath).section], index: indexPath.row, model: model);
        
        var array = dataSource[(indexPath as NSIndexPath).section];
        array.remove(at: indexPath.row);
        array.insert(model, at: indexPath.row);
        dataSource.remove(at: (indexPath as NSIndexPath).section);
        dataSource.insert(array, at: (indexPath as NSIndexPath).section);
        tableView.reloadData();
    }
    
    //MARK: - action
    func rightButtonAction() {
        let vc = SecretNewItemViewController(nibName: "SecretNewItemViewController", bundle: nil);
        vc.recordVC = self;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func longGestureAction(_ longGesture: UILongPressGestureRecognizer) {
        if longGesture.state != UIGestureRecognizerState.began{
            return;
        }
        self.tableView.isEditing = !self.tableView.isEditing;
    }
    
}
