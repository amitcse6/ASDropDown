//
//  ASDropDownView.swift
//  superapp
//
//  Created by Amit on 11/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public typealias ASDropDownViewItemIndex = Int
public typealias ASDropDownViewSelectionClosure = (ASDropDownViewItemIndex, String) -> Void

@available(iOS 9.0, *)
public class ASDropDownView: UIView {
    internal var anchorView: UIView?
    internal var items: [ASDropDownItem]?
    internal var prop: ASDropDownProp?
    
    internal var container: UIView?
    internal var boxView: UIView?
    internal var bropBox: ASDropDownBox?
    internal var PADDING: CGFloat = 8
    internal var boxPadding: CGPoint = CGPoint.zero
    internal var iscCornerRadius = true
    internal var containerSize: CGSize?
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if iscCornerRadius {
            let cornerRadius = (container?.bounds.size.height ?? 0 - PADDING*2) * 0.5
            container?.layer.cornerRadius = cornerRadius
        }
    }
    
    @objc func onTap(sender : AnyObject){
    }
}

@available(iOS 9.0, *)
extension ASDropDownView {
    @discardableResult
    func setEvent(_ selectionAction: ASDropDownViewSelectionClosure?) -> ASDropDownView {
        bropBox?.setEvent(selectionAction)
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ iscCornerRadius: Bool) -> ASDropDownView {
        self.iscCornerRadius = iscCornerRadius
        layoutSubviews()
        return self
    }
    
    @discardableResult
    public func setBordeColor(_ borderColor: UIColor) -> ASDropDownView {
        container?.layer.borderColor = borderColor.cgColor
        return self
    }
    
    @discardableResult
    public func setBordeWidth(_ borderWidth: CGFloat) -> ASDropDownView {
        container?.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    public func setCornerRadius(_ cornerRadius: CGFloat) -> ASDropDownView {
        container?.layer.cornerRadius = cornerRadius
        return self
    }
    
    @discardableResult
    public func setBorderColor(_ borderColor:UIColor) -> ASDropDownView {
        container?.layer.borderColor = borderColor.cgColor
        return self
    }
    
    @discardableResult
    public func setDefaultShadow() -> ASDropDownView {
        container?.asdShadowDefault(UIColor(asdValue: "#ffffff", alpha: 1.0), UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0), UIColor(asdValue: "#AAAAAA", alpha: 1.0), 5, scale: true)
        return self
    }
    
    @discardableResult
    public func setShadow(_ backgroundColor: UIColor, _ borderColor: UIColor, _ shadowColor: UIColor, _ shadowRadius: CGFloat, scale: Bool) -> ASDropDownView {
        container?.asdShadowDefault(UIColor(asdValue: "#ffffff", alpha: 1.0), UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0), UIColor(asdValue: "#AAAAAA", alpha: 1.0), 5, scale: true)
        return self
    }
}

extension UIView {
    public func asdShadowDefault(_ backgroundColor: UIColor, _ borderColor: UIColor, _ shadowColor: UIColor, _ shadowRadius: CGFloat, scale: Bool) {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = shadowRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowRadius
    }
}

@available(iOS 9.0, *)
extension UIColor {
    convenience init(asdRed: Int, green: Int, blue: Int, alpha: CGFloat) {
        assert(asdRed >= 0 && asdRed <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(asdRed) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(asdValue: Int, alpha: CGFloat) {
        self.init(red: CGFloat((asdValue >> 16) & 0xFF), green: CGFloat((asdValue >> 8) & 0xFF), blue: CGFloat(asdValue & 0xFF), alpha: alpha)
    }
    
    convenience init(asdValue: String, alpha: CGFloat = 1.0) {
        let hexString: String = asdValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func asdHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
