//
//  RootViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/5.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class RootViewController: SuperViewController {

    var transition: YZTransition!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        //self.navigationController?.navigationBar.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Funny";
        self.view.backgroundColor = UIColor.gray;
        self.configUI();
    }
    
    fileprivate func configUI() {
        let imageNames:[String] = ["content","gifShow","budejie","walfare","uc","netease","sina","secret","drawPicture","note","QR"];
        let titleArray:[String] = ["内涵段子","快手","不得姐","福利社","UC新闻","网易新闻","新浪新闻","Area","画图","Note","二维码"];
        
        let effect = UIBlurEffect(style: .extraLight);
        let effectView = UIVisualEffectView(effect: effect);
        effectView.frame = self.view.bounds;
        effectView.isUserInteractionEnabled = false;
        self.view.addSubview(effectView);
        
        for (index,value) in imageNames.enumerated() {
            let x = index % 4;
            let y = index / 4;
            let spaceX: CGFloat = (WIDTH - 240) / 5.0;
            let btn = UIButton(type: .system);
            btn.frame = CGRect(x: (spaceX + 60) * CGFloat(x) + spaceX, y: 84.0 + 100.0 * CGFloat(y), width: 60.0, height: 60.0);
            btn.tag = 100 + index;
            btn.layer.masksToBounds = true;
            btn.layer.cornerRadius = 12.0;
            let image = UIImage(named: value)?.withRenderingMode(.alwaysOriginal);
            btn.setImage(image, for: .normal);
            btn.addTarget(self, action: #selector(self.btnAction(_:)), for: .touchUpInside);
            let label = UILabel(frame: CGRect(x: (spaceX+60) * CGFloat(x)+spaceX, y: 65.0+84.0+100.0 * CGFloat(y), width: 60, height: 20));
            label.font = UIFont.systemFont(ofSize: 14.0);
            label.textColor = UIColor.black;
            label.text = titleArray[index];
            label.textAlignment = .center;
            self.view.addSubview(btn);
            self.view.addSubview(label);
        }
    }
    
    func btnAction(_ btn: UIButton) {
        self.intoVC(tag: btn.tag);
    }
    
    func intoVC(tag: Int) {
        transition = YZTransition();
        transition.type = .custom;
        if tag < FunnyApp.area.rawValue {
            var tvc: ExtentTabBarViewController?;
            if tag == FunnyApp.content.rawValue {
                tvc = ContentTabBarViewController();
            }else if tag == FunnyApp.gifShow.rawValue {
                tvc = GifShowTabBarViewController();
            }else if tag == FunnyApp.buDeJie.rawValue {
                tvc = BuDeJieTabBarViewController();
            }else if tag == FunnyApp.walfare.rawValue {
                tvc = WalfareTabBarViewController();
            }else if tag == FunnyApp.ucNews.rawValue {
                tvc = UCNewsTabBarViewController();
            }else if tag == FunnyApp.netEase.rawValue {
                tvc = NetEaseTabBarViewController();
            }else if tag == FunnyApp.sinaNews.rawValue {
                tvc = SinaNewsTabBarViewController();
            }
            tvc?.modalPresentationStyle = .custom;
            tvc?.transitioningDelegate = transition;
            self.navigationController?.present(tvc!, animated: true, completion: nil);
        }else{
            var vc: UIViewController?;
            if tag == FunnyApp.area.rawValue {
                vc = SecretLockViewController(nibName: "SecretLockViewController", bundle: nil);
            }else if tag == FunnyApp.drawPicture.rawValue {
                vc = DrawPicturesViewController(nibName: "DrawPicturesViewController", bundle: nil);
            }else if tag == FunnyApp.note.rawValue {
                vc = NoteLockViewController();
            }else if tag == FunnyApp.qrCode.rawValue {
                vc = QRHeaderViewController();
            }
            let nvc = ExtentNavigationViewController(rootViewController: vc!);
            transition.rotation = Rotation(x: 0, y: 1, z: 0, angle: CGFloat(M_PI_2));
            nvc.modalPresentationStyle = .custom;
            nvc.transitioningDelegate = transition;
            self.navigationController?.present(nvc, animated: true, completion: nil);
        }

    }
}
