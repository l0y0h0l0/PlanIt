//
//  UIViewController+mojiView.swift
//  PlanIt
//
//  Created by Ken on 16/7/2.
//  Copyright © 2016年 Ken. All rights reserved.
//
import UIKit
import Popover
extension UIViewController{
    ///发起提示
    func callAlertHUD(_ title:String, message: String){
        var showView = self.view
        if self.navigationController != nil{
            showView = self.navigationController?.view
        }
        let hud = MBProgressHUD.showAdded(to: showView!, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = title
        hud.detailsLabel.text = message
        //延迟隐藏
        hud.hide(animated: true, afterDelay: 1)
    }
    
    ///发起成功提示
    func callAlertSuccess(_ title:String){
        var showView = self.view
        if self.navigationController != nil{
            showView = self.navigationController?.view
        }
        let hud = MBProgressHUD.showAdded(to: showView!, animated: true)
        hud.mode = MBProgressHUDMode.customView
        hud.customView = UIImageView(image: UIImage(named: "Checkmark")!)
        hud.label.text = title
        hud.bezelView.color = UIColor.colorFromHex("#CACACA")
        //延迟隐藏
        hud.hide(animated: true, afterDelay: 1)
    }
    
    ///发起失败提示
    func callAlertFailed(_ title:String){
        var showView = self.view
        if self.navigationController != nil{
            showView = self.navigationController?.view
        }
        let hud = MBProgressHUD.showAdded(to: showView!, animated: true)
        hud.mode = MBProgressHUDMode.customView
        hud.customView = UIImageView(image: UIImage(named: "failmark")!)
        hud.label.text = title
        //延迟隐藏
        hud.hide(animated: true, afterDelay: 1)
    }
    
    ///发起系统提示
    func callAlert(_ title:String, message: String, completion: (() -> Void)? = nil){
        if !IS_IOS9{
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default,
                                         handler: nil)
            alertController.addAction(okAction)
            
            if let popoverPresentationController = alertController.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect =  CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
            }
            
            self.present(alertController, animated: true, completion: completion)

        }else{
            // Create the dialog
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: true) {
                print("Completed")
                completion?()
                
            }
            
            // Create first button
            // Create second button
            let buttonTwo = DefaultButton(title: NSLocalizedString("OK", comment: "")) {
                
            }
            
            // Add buttons to dialog
            popup.addButtons([buttonTwo])
            
            // Present dialog
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    ///发起询问提示
    func callAlertAsk(_ title:String, message:String = "" ,okHandler: ((UIAlertAction) -> Void)?, cancelandler: ((UIAlertAction) -> Void)?, completion: (() -> Void)?){
        if !IS_IOS9{
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            //创建UIAlertAction 确定按钮
            let alerActionOK = UIAlertAction(title: NSLocalizedString("Confirm", comment: ""), style: .destructive, handler: okHandler)
            //创建UIAlertAction 取消按钮
            let alerActionCancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: cancelandler)
            //添加动作
            alertController.addAction(alerActionOK)
            alertController.addAction(alerActionCancel)
            
            if let popoverPresentationController = alertController.popoverPresentationController {
                popoverPresentationController.sourceView = self.view
                popoverPresentationController.sourceRect =  CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
            }
            
            //显示alert
            self.present(alertController, animated: true, completion: completion)

        }else{
            // Create the dialog
            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: true) {
                print("Completed")
                completion?()
            }
            
            // Create first button
            let buttonOne = CancelButton(title: NSLocalizedString("Cancel", comment: "")) {
                cancelandler?(UIAlertAction())
            }
            
            // Create second button
            let buttonTwo = DefaultButton(title: NSLocalizedString("Confirm", comment: "")) {
                okHandler?(UIAlertAction())
            }
            
            // Add buttons to dialog
            popup.addButtons([buttonTwo, buttonOne])
            
            // Present dialog
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    ///用户引导页面
    func callFirstRemain(_ title:String, view: UIView, type:PopoverType = .down,showHandler: (() -> ())? = nil, dismissHandler: (() -> ())? = nil){
        //创建label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.white
        //自适应大小
        titleLabel.sizeToFit()
        
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: titleLabel.bounds.width + 30 , height: titleLabel.bounds.height + 20 ))
        titleLabel.center = aView.center
        aView.addSubview(titleLabel)
        
        ///提示弹窗参数
        let popoverOptions: [PopoverOption] = [
            .type(type),
            .cornerRadius(6.0),
            .animation(.none)
        ]
        let popover = Popover(options: popoverOptions, showHandler: showHandler, dismissHandler: dismissHandler)
        popover.showAlpha = 0.1
        popover.popoverColor = UIColor(red:0.35, green:0.64, blue:1.00, alpha:1.00)
        popover.show(aView, fromView: view)
    }

    ///用户引导页面
    func callFirstRemainMultiLine(_ title:String, view: UIView, type:PopoverType = .down,showHandler: (() -> ())? = nil, dismissHandler: (() -> ())? = nil){
        //创建label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        // 调整行间距
        let attributedString = NSMutableAttributedString(string: titleLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        attributedString.addAttributes([NSParagraphStyleAttributeName : paragraphStyle], range: NSMakeRange(0, titleLabel.text!.characters.count))
        titleLabel.attributedText = attributedString
        //自适应大小
        titleLabel.sizeToFit()
        
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: titleLabel.bounds.width + 30 , height: titleLabel.bounds.height + 20 ))
        titleLabel.center = aView.center
        aView.addSubview(titleLabel)
        
        ///提示弹窗参数
        let popoverOptions: [PopoverOption] = [
            .type(type),
            .cornerRadius(6.0),
            .animation(.none)
        ]
        let popover = Popover(options: popoverOptions, showHandler: showHandler, dismissHandler: dismissHandler)
        popover.showAlpha = 0.1
        popover.popoverColor = UIColor(red:0.35, green:0.64, blue:1.00, alpha:1.00)
        popover.show(aView, fromView: view)
    }
    
    ///用户引导页面
    func callFirstRemain(_ title:String, startPoint: CGPoint, type:PopoverType = .down,showHandler: (() -> ())? = nil, dismissHandler: (() -> ())? = nil){
        //创建label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.white
        //自适应大小
        titleLabel.sizeToFit()
        
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: titleLabel.bounds.width + 30 , height: titleLabel.bounds.height + 20 ))
        titleLabel.center = aView.center
        aView.addSubview(titleLabel)
        
        ///提示弹窗参数
        let popoverOptions: [PopoverOption] = [
            .type(type),
            .cornerRadius(6.0),
            .animation(.none)
        ]
        let popover = Popover(options: popoverOptions, showHandler: showHandler, dismissHandler: dismissHandler)
        popover.showAlpha = 0.1
        popover.popoverColor = UIColor(red:0.35, green:0.64, blue:1.00, alpha:1.00)
        popover.show(aView, point: startPoint)
    }
    
    func getCurrentVC()->UIViewController{
        
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal{
            let windows = UIApplication.shared.windows
            for  tempwin in windows{
                if tempwin.windowLevel == UIWindowLevelNormal{
                    window = tempwin
                    break
                }
            }
        }
        let frontView = (window?.subviews)![0]
        let nextResponder = frontView.next

        if nextResponder?.isKind(of: UIViewController.classForCoder()) == true{
            
            return nextResponder as! UIViewController
        }else if nextResponder?.isKind(of: UINavigationController.classForCoder()) == true{
            
            return (nextResponder as! UINavigationController).visibleViewController!
        }
        else {
            
            if (window?.rootViewController) is UINavigationController{
                return ((window?.rootViewController) as! UINavigationController).visibleViewController!//只有这个是显示的controller 是可以的必须有nav才行
            }else if (window?.rootViewController) is UITabBarController{
                return ((window?.rootViewController) as! UITabBarController).selectedViewController! //不行只是最三个开始的页面
            }
            
            return (window?.rootViewController)!
            
        }
        
    }
}

extension UIView{
    func pointInView(_ point: CGPoint) -> Bool{
        if point.x > bounds.width || point.x < 0 || point.y > bounds.height || point.y < 0 {
            return false
        }else{
            return true
        }
    }
}
