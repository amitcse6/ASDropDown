//
//  ASDropDownViewNormal.swift
//  superapp
//
//  Created by Amit on 11/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
public class ASDropDownViewDefault: ASDropDownView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public init(_ anchorView: UIView?, _ items: [ASDropDownItem]?, _ containerSize: CGSize?) {
        super.init(frame: CGRect.zero)
        self.anchorView = anchorView
        self.items = items
        self.containerSize = containerSize
        setup()
    }
    
    public func setup() {
        setupUIElements()
        setupConstraints() 
        bropBox?.addItems(items)
    }
    
    public func setupUIElements() {
        iscCornerRadius = false
        container = UIView()
        addSubview(container.unsafelyUnwrapped)
        container?.backgroundColor = .clear
        
        
        boxView = UIView()
        container?.addSubview(boxView.unsafelyUnwrapped)
        boxView?.layer.rasterizationScale = UIScreen.main.scale
        boxView?.layer.shouldRasterize = true
        boxView?.asdShadowDefault(UIColor(asdRed: "#ffffff", alpha: 1.0), UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0), UIColor(asdRed: "#AAAAAA", alpha: 1.0), 5, scale: true) 
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        gesture.numberOfTapsRequired = 1
        boxView?.addGestureRecognizer(gesture)
        boxView?.isUserInteractionEnabled = true
        
        bropBox = ASDropDownBox()
        boxView?.addSubview(bropBox.unsafelyUnwrapped)
        bropBox?.backgroundColor = .clear
    }
}
