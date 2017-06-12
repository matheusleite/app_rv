//
//  DesignManager.swift
//  Square
//
//  Created by Matheus Leite on 06/05/16.
//  Copyright © 2016 Matheus Leite. All rights reserved.
//

import UIKit

class DesignManager: NSObject {
    
    static let sharedInstance = DesignManager()
    
    let navyBlue = UIColor(hexString: "#2C3E50")
    let flatRed = UIColor(hexString: "#E74C3C")
    let flatWhite = UIColor(hexString: "#ECF0F1")
    let cleanBlue = UIColor(hexString: "#3498DB")
    let flatBlue = UIColor(hexString: "#2980B9")

    let username = "ubuntu"
    let password = "squareapp"
    
    override init() {
        var fontAttributes = [String : AnyObject]()
        let font = UIFont(name: "Quicksand-Medium", size: 17)
        fontAttributes = [NSFontAttributeName : font!, NSForegroundColorAttributeName : flatWhite]
//
//        //UINavigationBar.appearance().setBackgroundImage(UIImage(named: "logo"), for: UIBarMetrics.default)
//        UINavigationBar.appearance().isTranslucent = false
//        //UIBarButtonItem.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = fontAttributes
        UIBarButtonItem.appearance().setTitleTextAttributes(fontAttributes, for: UIControlState.normal)
//        UIApplication.shared.statusBarStyle = .default
    }
    
    //    func formatDate(dateString: String, dateFormat: String) -> String {
    //        let formatter = NSDateFormatter()
    //        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //
    //        let date = formatter.dateFromString(dateString)
    //
    //        formatter.dateFormat = dateFormat
    //
    //        return formatter.stringFromDate(date!)
    //    }
    //
    //    func resizeImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
    //        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
    //        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
    //        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //        return newImage
    //    }
}

extension UIViewController {
    
//    func setNavBarLogo() {
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
//        self.navigationItem.titleView = imageView
//    }
    
    //    func showLoader(loader: MDProgress) {
    //        loader.progressColor = UIColor.grayColor()
    //        loader.backgroundColor = UIColor.clearColor()
    //        loader.progressType = .Indeterminate//        loader.progressStyle = .Circular
    
    ////        loader.frame.size.width = 100
    ////        loader.frame.size.height = 100
    //        loader.center.x = self.view.center.x
    //        loader.center.y = self.view.center.y
    //
    //        //hidden all subviews
    //        for view in self.view.subviews {
    //            view.hidden = true
    //        }
    //
    //        self.view.addSubview(loader)
    //    }
    //
    //    func showLoader(loader: MDProgress, withHeightPadding padding: CGFloat) {
    //        loader.progressColor = UIColor.grayColor()
    //        loader.backgroundColor = UIColor.clearColor()
    //        loader.progressType = .Indeterminate
    //        loader.progressStyle = .Circular
    //
    ////        loader.frame.size.width = 100
    ////        loader.frame.size.height = 100
    //        loader.center.x = self.view.center.x
    //        loader.center.y = self.view.center.y - padding
    //
    //        //hidden all subviews
    //        for view in self.view.subviews {
    //            view.hidden = true
    //        }
    //
    //        self.view.addSubview(loader)
    //    }
    //
    //    func removeLoader(loader: MDProgress) {
    //        loader.removeFromSuperview()
    //        loader.progressColor = UIColor.clearColor()
    //
    //        for view in self.view.subviews {
    //            view.hidden = false
    //        }
    //    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //    func emptyMessage(message: String, tableView: UITableView) {
    //        let messageLabel = UILabel(frame: CGRectMake(0,0, tableView.frame.size.width, tableView.frame.size.height))
    //        messageLabel.text = message
    //        messageLabel.textColor = DesignManager.sharedInstance.redColor
    //        messageLabel.numberOfLines = 0;
    //        messageLabel.textAlignment = .Center;
    //        messageLabel.font = UIFont(name: "Lato-Regular", size: 25)
    //        messageLabel.sizeToFit()
    //
    //        tableView.backgroundView = messageLabel;
    //        tableView.separatorStyle = .None;
    //    }
    //
    //    func emptyMessage(message: String, collectionView: UICollectionView) {
    //        let messageLabel = UILabel(frame: CGRectMake(0,0, collectionView.frame.size.width, collectionView.frame.size.height))
    //        messageLabel.text = message
    //        messageLabel.textColor = DesignManager.sharedInstance.redColor
    //        messageLabel.numberOfLines = 0;
    //        messageLabel.textAlignment = .Center;
    //        messageLabel.font = UIFont(name: "Lato-Regular", size: 25)
    //        messageLabel.sizeToFit()
    //
    //        collectionView.backgroundView = messageLabel;
    //    }
    //}
    //
    //extension UIView {
    //    func makeMeBlur(withSize frame: CGRect, andBlurStyle style: UIBlurEffectStyle) {
    //        self.backgroundColor = UIColor.clearColor()
    //
    //        let blurEffect = UIBlurEffect(style: style)
    //        let blurEffectView = UIVisualEffectView(effect: blurEffect)
    //        blurEffectView.frame = frame
    //
    //        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    //
    //        self.addSubview(blurEffectView)
    //    }
}

extension UIColor {
        convenience init(hexString:String) {
            let scanner  = Scanner(string: hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            
            if (hexString.hasPrefix("#")) {
                scanner.scanLocation = 1
            }
            
            var color:UInt32 = 0
            scanner.scanHexInt32(&color)
            
            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            
            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0
            
            self.init(red:red, green:green, blue:blue, alpha:1)
        }

}

//identify devices by name
public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

//extension UIButton {
//    func centerTextAndImage(spacing: CGFloat) {
//        let insetAmount = spacing / 2
//        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
//        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
//        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
//    }
//
//    func paintImage(image: UIImage, withColor color: UIColor) {
//        self.setImage(image.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
//        self.tintColor = color
//    }
//
//    func createButtonToNavBarWithImage(image: UIImage, AndText text: String) {
//        self.setImage(image, forState: .Normal)
//        self.setTitle(text, forState: .Normal)
//        self.titleLabel?.font = UIFont(name: "Lato-Regular", size: 15)
//    }
//}
//
//extension String {
//    func toDouble() -> Double {
//        let formatter = NSNumberFormatter()
//        formatter.decimalSeparator = ","
//        let number = formatter.numberFromString(self)
//        
//        return number!.doubleValue
//    }
//}
