//
//  Super3DTouchViewController.swift
//  Funny
//
//  Created by yanzhen on 16/7/5.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class Super3DTouchViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    fileprivate var text: String!
    init() {
        super.init(nibName: "Super3DTouchViewController", bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}
