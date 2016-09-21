//
//  SecretNewItemViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/7.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class SecretNewItemViewController: UIViewController,SecretKeyBoardToolProtocol,SecretTitleViewDelegate {
    
    var recordVC: SecretRecordViewController!
    var model: SecretModel!
    var indexPath: IndexPath!
    var titleIndex: Int!
    var isModify: Bool! = false
    var keyBoardFrame: CGRect?
    @IBOutlet fileprivate weak var rowTextField: YZTextField!
    @IBOutlet fileprivate weak var companyTF: YZTextField!
    @IBOutlet fileprivate weak var accountTF: YZTextField!
    @IBOutlet fileprivate weak var passwordTF: YZTextField!
    @IBOutlet fileprivate weak var remarksTF: YZTextField!
    var textFields = [YZTextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isModify! {
            rowTextField.text = secretTitleArray[indexPath.section];
            companyTF.text = model.company;
            accountTF.text = model.account;
            passwordTF.text = model.password;
            remarksTF.text = model.remarks;
        }
        self.configUI();
    }
    
    //MARK: - Action
    func rowButtonAction() {
        if !self.isModify! {
            self.titleView.toggleSecretTitleView();
        }
    }
    
    func saveButtonAction() {
        if self.oneTextFieldIsNil() {
            return;
        }
        if isModify! {
            let model = SecretModel();
            model.company = companyTF.text;
            model.account = accountTF.text;
            model.password = passwordTF.text;
            model.remarks = remarksTF.text;
            recordVC.modifyItem(indexPath, model: model);
        }else{
            let model = SecretModel();
            model.company = companyTF.text;
            model.account = accountTF.text;
            model.password = passwordTF.text;
            model.remarks = remarksTF.text;
            recordVC.addNewItem(titleIndex, model: model);
        }
        self.navigationController!.popViewController(animated: true);
    }
    
    fileprivate func oneTextFieldIsNil() ->Bool {
        
        if rowTextField.text!.isEmpty {
            self.view.makeCenterToast("请选择分组");
        }else if (companyTF.text!.isEmpty) {
            self.view.makeCenterToast("请选择公司");
        }else if (accountTF.text!.isEmpty) {
            self.view.makeCenterToast("请输入账号");
        }else if (passwordTF.text!.isEmpty) {
            self.view.makeCenterToast("请输入密码");
        }else if (remarksTF.text!.isEmpty) {
            self.view.makeCenterToast("请输入备注");
        }else{
            return false;
        }
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hiddenTitleView();
        
        for (_,value) in textFields.enumerated() {
            if value.isFirstResponder {
                value.resignFirstResponder();
            }
        }
    }
    //MARK: - KeyBoardToolDelegate
    func SecretKeyBoardItemAction(_ index: Int) {
        if index == SecretKBTool.pre.rawValue{
            self.pre();
        }else if index == SecretKBTool.next.rawValue {
            self.next();
        }else if index == SecretKBTool.done.rawValue {
            self.done();
        }
    }
    
    fileprivate func pre() {
        let index = self.currentResponderIndex() - 1;
        if index >= 1 {
            let textField = textFields[index];
            textField.becomeFirstResponder();
            self.changeKeyBoardFrame();
        }
    }
    
    fileprivate func next() {
        let index = self.currentResponderIndex() + 1;
        if index < textFields.count {
            let textField = textFields[index];
            textField.becomeFirstResponder();
            self.changeKeyBoardFrame();
        }
        
    }
    
    fileprivate func done() {
        self.view.endEditing(true);
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.view.transform = CGAffineTransform.identity;
        })
    }
    
    fileprivate func currentResponderIndex() ->Int {
        for (index,value) in textFields.enumerated() {
            if value.isFirstResponder {
                return index;
            }
        }
        return -1;
    }
    
    fileprivate func changeKeyBoardFrame() {
        let frame = keyBoardFrame;
        let kbEndY = frame!.origin.y;
        let currentIndex = self.currentResponderIndex();
        if currentIndex < 0 {
            return;
        }
        let currentTf = textFields[currentIndex];
        let tfMaxY = currentTf.frame.maxY;
        if tfMaxY > kbEndY {
            UIView.animate(withDuration: 0.15, animations: { () -> Void in
                self.view.transform = CGAffineTransform(translationX: 0, y: kbEndY - tfMaxY);
            })
        }else{
            self.view.transform = CGAffineTransform.identity;
        }
    }
    
    func keyboardFrameChange(_ notifi: Notification) {
        let userInfo = (notifi as NSNotification).userInfo as! Dictionary<String,AnyObject>;
        let frame: AnyObject? = userInfo[UIKeyboardFrameEndUserInfoKey];
        keyBoardFrame = frame?.cgRectValue;
        self.changeKeyBoardFrame();
    }
    
    //MARK: - UI
    
    fileprivate func configUI() {
        textFields = [rowTextField,companyTF,accountTF,passwordTF,remarksTF];
        let keyBoardTool = Bundle.main.loadNibNamed("SecretKeyBoardTool", owner: self, options: nil)?.last as! SecretKeyBoardTool;
        keyBoardTool.delegate = self;
        for (_,value) in textFields.enumerated() {
            value.inputAccessoryView = keyBoardTool;
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardFrameChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil);
        
        let rowButton = UIButton(type:UIButtonType.system);
        rowButton.frame = CGRect(x: 30.0, y: rowTextField.y, width: WIDTH - 60, height: rowTextField.height);
        rowButton.backgroundColor = UIColor.clear;
        rowButton.layer.masksToBounds = true;
        rowButton.layer.cornerRadius = 6.0;
        rowButton.addTarget(self, action: #selector(self.rowButtonAction), for: UIControlEvents.touchUpInside);
        self.view.addSubview(rowButton);
        //
        let saveBtn = UIButton(type:UIButtonType.system);
        saveBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        saveBtn.backgroundColor = UIColor.clear;
        saveBtn.setTitle("确定", for: UIControlState());
        saveBtn.addTarget(self, action: #selector(self.saveButtonAction), for: UIControlEvents.touchUpInside);
        let rightBarButtonItem = UIBarButtonItem(customView: saveBtn);
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
    //MARK: - titleView
    lazy var titleView: SecretTitleView = {
        let titleView = SecretTitleView(frame: CGRect(x: 30, y: self.rowTextField.frame.maxY, width: WIDTH - 60.0, height: 0));
        titleView.delegate = self;
        self.view.addSubview(titleView);
        return titleView;
        }()
    
    func SecretTitleViewSelect(_ indexPath: IndexPath) {
        self.rowTextField.text = secretTitleArray[(indexPath as NSIndexPath).row];
        titleIndex = (indexPath as NSIndexPath).row;
    }
    
    fileprivate func hiddenTitleView() {
        if !self.titleView.isHidden {
            self.titleView.toggleSecretTitleView();
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
}
