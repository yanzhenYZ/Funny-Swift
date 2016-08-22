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
    var indexPath: NSIndexPath!
    var titleIndex: Int!
    var isModify: Bool! = false
    var keyBoardFrame: CGRect?
    @IBOutlet weak var rowTextField: YZTextField!
    @IBOutlet weak var companyTF: YZTextField!
    @IBOutlet weak var accountTF: YZTextField!
    @IBOutlet weak var passwordTF: YZTextField!
    @IBOutlet weak var remarksTF: YZTextField!
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
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    private func oneTextFieldIsNil() ->Bool {
        
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.hiddenTitleView();
        
        for (_,value) in textFields.enumerate() {
            if value.isFirstResponder() {
                value.resignFirstResponder();
            }
        }
    }
    //MARK: - KeyBoardToolDelegate
    func SecretKeyBoardItemAction(index: Int) {
        if index == SecretKBTool.Pre.rawValue{
            self.pre();
        }else if index == SecretKBTool.Next.rawValue {
            self.next();
        }else if index == SecretKBTool.Done.rawValue {
            self.done();
        }
    }
    
    private func pre() {
        let index = self.currentResponderIndex() - 1;
        if index >= 1 {
            let textField = textFields[index];
            textField.becomeFirstResponder();
            self.changeKeyBoardFrame();
        }
    }
    
    private func next() {
        let index = self.currentResponderIndex() + 1;
        if index < textFields.count {
            let textField = textFields[index];
            textField.becomeFirstResponder();
            self.changeKeyBoardFrame();
        }
        
    }
    
    private func done() {
        self.view.endEditing(true);
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.view.transform = CGAffineTransformIdentity;
        })
    }
    
    private func currentResponderIndex() ->Int {
        for (index,value) in textFields.enumerate() {
            if value.isFirstResponder() {
                return index;
            }
        }
        return -1;
    }
    
    private func changeKeyBoardFrame() {
        let frame = keyBoardFrame;
        let kbEndY = frame!.origin.y;
        let currentIndex = self.currentResponderIndex();
        if currentIndex < 0 {
            return;
        }
        let currentTf = textFields[currentIndex];
        let tfMaxY = CGRectGetMaxY(currentTf.frame);
        if tfMaxY > kbEndY {
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                self.view.transform = CGAffineTransformMakeTranslation(0, kbEndY - tfMaxY);
            })
        }else{
            self.view.transform = CGAffineTransformIdentity;
        }
    }
    
    func keyboardFrameChange(notifi: NSNotification) {
        let userInfo = notifi.userInfo as! Dictionary<String,AnyObject>;
        let frame: AnyObject? = userInfo[UIKeyboardFrameEndUserInfoKey];
        keyBoardFrame = frame?.CGRectValue();
        self.changeKeyBoardFrame();
    }
    
    //MARK: - UI
    
    private func configUI() {
        textFields = [rowTextField,companyTF,accountTF,passwordTF,remarksTF];
        let keyBoardTool = NSBundle.mainBundle().loadNibNamed("SecretKeyBoardTool", owner: self, options: nil).last as! SecretKeyBoardTool;
        keyBoardTool.delegate = self;
        for (_,value) in textFields.enumerate() {
            value.inputAccessoryView = keyBoardTool;
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardFrameChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil);
        
        let rowButton = UIButton(type:UIButtonType.System);
        rowButton.frame = CGRectMake(30.0, rowTextField.y, WIDTH - 60, rowTextField.height);
        rowButton.backgroundColor = UIColor.clearColor();
        rowButton.layer.masksToBounds = true;
        rowButton.layer.cornerRadius = 6.0;
        rowButton.addTarget(self, action: #selector(self.rowButtonAction), forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(rowButton);
        //
        let saveBtn = UIButton(type:UIButtonType.System);
        saveBtn.frame = CGRectMake(0, 0, 40, 40);
        saveBtn.backgroundColor = UIColor.clearColor();
        saveBtn.setTitle("确定", forState: UIControlState.Normal);
        saveBtn.addTarget(self, action: #selector(self.saveButtonAction), forControlEvents: UIControlEvents.TouchUpInside);
        let rightBarButtonItem = UIBarButtonItem(customView: saveBtn);
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
    //MARK: - titleView
    lazy var titleView: SecretTitleView = {
        let titleView = SecretTitleView(frame: CGRectMake(30, CGRectGetMaxY(self.rowTextField.frame), WIDTH - 60.0, 0));
        titleView.delegate = self;
        self.view.addSubview(titleView);
        return titleView;
        }()
    
    func SecretTitleViewSelect(indexPath: NSIndexPath) {
        self.rowTextField.text = secretTitleArray[indexPath.row];
        titleIndex = indexPath.row;
    }
    
    private func hiddenTitleView() {
        if !self.titleView.isHidden {
            self.titleView.toggleSecretTitleView();
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
}
