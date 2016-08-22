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
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        //self.navigationController?.navigationBar.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Funny";
        self.configUI();
    }
    
    private func configUI() {
        let imageNames:[String] = ["艾斯","鹰眼","女帝","明哥","黑胡子","白胡子","红发","白胡子_logo","乔巴","索隆","罗宾"];
        let titleArray:[String] = ["内涵段子","快手","不得姐","福利社","UC新闻","网易新闻","新浪新闻","Area","画图","Note","二维码"];
        
        for (index,value) in imageNames.enumerate() {
            let x = index % 4;
            let y = index / 4;
            let spaceX: CGFloat = (WIDTH - 240) / 5.0;
            let btn = UIButton(type: UIButtonType.System);
            btn.frame = CGRectMake((spaceX + 60) * CGFloat(x) + spaceX, 84.0 + 100.0 * CGFloat(y), 60.0, 60.0);
            btn.tag = 100 + index;
            btn.layer.masksToBounds=true;
            btn.layer.cornerRadius=8.0;
            let image=UIImage(named: value)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
            btn.setImage(image, forState: UIControlState.Normal);
            btn.addTarget(self, action: #selector(self.btnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside);
            let label=UILabel(frame: CGRectMake((spaceX+60) * CGFloat(x)+spaceX, 65.0+84.0+100.0 * CGFloat(y), 60, 20));
            label.font=UIFont.systemFontOfSize(14.0);
            label.textColor=UIColor.blueColor();
            label.text=titleArray[index];
            label.textAlignment=NSTextAlignment.Center;
            self.view.addSubview(btn);
            self.view.addSubview(label);
        }
    }
    
    func btnAction(btn: UIButton) {
        transition = YZTransition();
        transition.type = .Custom;
        if btn.tag < FunnyApp.Area.rawValue {
            var tvc: ExtentTabBarViewController?;
            if btn.tag == FunnyApp.Content.rawValue {
                tvc = ContentTabBarViewController();
            }else if btn.tag == FunnyApp.GifShow.rawValue {
                tvc = GifShowTabBarViewController();
            }else if btn.tag == FunnyApp.BuDeJie.rawValue {
                tvc = BuDeJieTabBarViewController();
            }else if btn.tag == FunnyApp.Walfare.rawValue {
                tvc = WalfareTabBarViewController();
            }else if btn.tag == FunnyApp.UCNews.rawValue {
                tvc = UCNewsTabBarViewController();
            }else if btn.tag == FunnyApp.NetEase.rawValue {
                tvc = NetEaseTabBarViewController();
            }else if btn.tag == FunnyApp.SinaNews.rawValue {
                tvc = SinaNewsTabBarViewController();
            }
            tvc?.modalPresentationStyle = .Custom;
            tvc?.transitioningDelegate = transition;
            self.navigationController?.presentViewController(tvc!, animated: true, completion: nil);
        }else{
            var vc: UIViewController?;
            if btn.tag == FunnyApp.Area.rawValue {
                vc = SecretLockViewController(nibName: "SecretLockViewController", bundle: nil);
            }else if btn.tag == FunnyApp.DrawPicture.rawValue {
                vc = DrawPicturesViewController(nibName: "DrawPicturesViewController", bundle: nil);
            }else if btn.tag == FunnyApp.Note.rawValue {
                vc = NoteLockViewController();
            }else if btn.tag == FunnyApp.QRCode.rawValue {
                vc = QRHeaderViewController();
            }
            let nvc=ExtentNavigationViewController(rootViewController: vc!);
            transition.rotation = Rotation(x: 0, y: 1, z: 0, angle: CGFloat(M_PI_2));
            nvc.modalPresentationStyle = .Custom;
            nvc.transitioningDelegate = transition;
            self.navigationController?.presentViewController(nvc, animated: true, completion: nil);
        }
    }
}
