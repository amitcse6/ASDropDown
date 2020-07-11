//
//  ASDropDownView+Ectensions.swift
//  superapp
//
//  Created by Amit on 11/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
extension ASDropDownView {
    // MARK: - Default
    public func setupConstraints() {
        container?.translatesAutoresizingMaskIntoConstraints = false
        container?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        container?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        container?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        container?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        boxView?.translatesAutoresizingMaskIntoConstraints = false
        if let anchorView = anchorView, let globalPoint = anchorView.superview?.convert(anchorView.frame.origin, to: nil) {
            let screenSize = UIScreen.main.bounds
            let anchorViewSize = anchorView.bounds.size
            let anchorViewCenterX: CGFloat = globalPoint.x + anchorViewSize.width/2
            let anchorViewCenterY: CGFloat = globalPoint.y + anchorViewSize.height/2
            
            if anchorViewCenterX > screenSize.width/2 {
                let rightConstant = screenSize.width - (globalPoint.x + anchorViewSize.width)
                boxView?.rightAnchor.constraint(equalTo: container.unsafelyUnwrapped.rightAnchor, constant: -rightConstant).isActive = true
                
                let leftAnchor = boxView?.leftAnchor.constraint(greaterThanOrEqualTo: container.unsafelyUnwrapped.leftAnchor)
                leftAnchor?.priority = UILayoutPriority(rawValue: 1000)
                leftAnchor?.isActive = true
            }else {
                let leftConstant = (globalPoint.x + anchorViewSize.width)
                boxView?.leftAnchor.constraint(equalTo: container.unsafelyUnwrapped.leftAnchor, constant: leftConstant).isActive = true
                
                let rightAnchor = boxView?.rightAnchor.constraint(lessThanOrEqualTo: container.unsafelyUnwrapped.rightAnchor)
                rightAnchor?.priority = UILayoutPriority(rawValue: 1000)
                rightAnchor?.isActive = true
            }
            
            if anchorViewCenterY > screenSize.height/2 {
                let bottomConstant = screenSize.height - (globalPoint.y + anchorViewSize.height)
                boxView?.bottomAnchor.constraint(equalTo: container.unsafelyUnwrapped.bottomAnchor, constant: -bottomConstant).isActive = true
                
                let topAnchor = boxView?.topAnchor.constraint(greaterThanOrEqualTo: container.unsafelyUnwrapped.topAnchor)
                topAnchor?.priority = UILayoutPriority(rawValue: 1000)
                topAnchor?.isActive = true
            }else {
                let topConstant = (globalPoint.y)
                boxView?.topAnchor.constraint(equalTo: container.unsafelyUnwrapped.topAnchor, constant: topConstant).isActive = true
                
                let bottomAnchor = boxView?.bottomAnchor.constraint(lessThanOrEqualTo: container.unsafelyUnwrapped.bottomAnchor)
                bottomAnchor?.priority = UILayoutPriority(rawValue: 1000)
                bottomAnchor?.isActive = true
            }
            
            
            if let width = containerSize?.width, width > 0  {
                boxView?.widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            if let height = containerSize?.height, height > 0 {
                boxView?.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        
        bropBox?.translatesAutoresizingMaskIntoConstraints = false
        bropBox?.topAnchor.constraint(equalTo: boxView.unsafelyUnwrapped.topAnchor).isActive = true
        bropBox?.leftAnchor.constraint(equalTo: boxView.unsafelyUnwrapped.leftAnchor).isActive = true
        bropBox?.rightAnchor.constraint(equalTo: boxView.unsafelyUnwrapped.rightAnchor).isActive = true
        bropBox?.bottomAnchor.constraint(equalTo: boxView.unsafelyUnwrapped.bottomAnchor).isActive = true
    }
}
