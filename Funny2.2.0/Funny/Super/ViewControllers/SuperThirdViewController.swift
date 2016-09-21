//
//  SuperThirdViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class SuperThirdViewController: SuperSecondViewController,UITableViewDelegate,UITableViewDataSource {
    var header: MJRefreshHeaderView?
    var footer: MJRefreshFooterView?
    @IBOutlet weak var tableView: UITableView!
    
    deinit{
        header?.free();
        footer?.free();
    }
    
    init() {
        super.init(nibName: "SuperThirdViewController", bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    

}
