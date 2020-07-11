//
//  ASDropDown.swift
//  superapp
//
//  Created by Amit on 6/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public typealias ASDropDownIndex = Int
public typealias ASDropDownSelectionClosure = (ASDropDownIndex, String) -> Void

@available(iOS 9.0, *)
public class ASDropDown: NSObject {
    static var sharedManager: ASDropDown?
    
    @discardableResult
    static func shared() -> ASDropDown? {
        if sharedManager == nil {
            sharedManager = ASDropDown()
        }
        return sharedManager
    }
    
    private override init() {
    }
    
    internal var dropDownView: ASDropDownView?
    internal var rootPadding: CGFloat = 16
    internal var withDuration: TimeInterval = 3
    internal var delay: TimeInterval = 1
    
    private func openDropDown(_ items: [ASDropDownItem], _ selectionAction: @escaping ASDropDownSelectionClosure, _ anchorView: UIView?, _ size: CGSize?) {
        if #available(iOS 11.0, *) {
            if let viewController = ASDropDown.topMostVC {
                dropDownView = ASDropDownViewDefault(anchorView, items, size)
                viewController.view.addSubview(dropDownView.unsafelyUnwrapped)
                dropDownView?.setEvent(selectionAction)
                dropDownView?.translatesAutoresizingMaskIntoConstraints = false
                
                dropDownView?.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor).isActive = true
                
                dropDownView?.leftAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leftAnchor).isActive = true
                dropDownView?.rightAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.rightAnchor).isActive = true
                dropDownView?.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                dropDownView?.setEvent({ [unowned self] (index, title) in
                    selectionAction(index, title)
                    self.dismiss()
                })
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
                gesture.numberOfTapsRequired = 1
                dropDownView?.addGestureRecognizer(gesture)
                dropDownView?.isUserInteractionEnabled = true
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func onTap(sender : AnyObject){
        dismiss()
    }
    
    private func dismiss() {
        if let dropDown = ASDropDown.shared() {
            if (dropDown.dropDownView != nil) {
                dropDown.dropDownView?.container?.layer.removeAllAnimations()
                dropDown.dropDownView?.removeFromSuperview()
                dropDown.dropDownView = nil
            }
        }
    }
    
    @objc private func dismissWithAnimation() {
        UIView.animate(withDuration: withDuration, delay: delay, options: [.allowUserInteraction], animations: { () -> Void in
            self.dropDownView?.container?.alpha = 0
        }, completion: { (finished) in
            self.dismiss()
        })
    }
}

@available(iOS 9.0, *)
extension ASDropDown {
    public static func openDropDown(_ items: [ASDropDownItem], _ selectionAction: @escaping ASDropDownSelectionClosure, _ anchorView: UIView?, _ size: CGSize?) {
        ASDropDown.dismiss()
        if let dropDown = ASDropDown.shared() {
            dropDown.openDropDown(items, selectionAction, anchorView, size)
        }
    }
    
    static func dismiss() {
        if let dropDown = ASDropDown.shared() {
            dropDown.dismiss()
        }
    }
    
    private static var topMostVC: UIViewController? {
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController {
            presentedVC = pVC
        }
        if presentedVC == nil {
            print("Error: You don't have any views set.")
        }
        return presentedVC
    }
}

public class ASDropDownGestureRecognizer: UITapGestureRecognizer {
    var firstObject: Any?
    
    func setFirstObject(_ sender: Any?) {
        self.firstObject = sender
    }
    
    func getFirstObject() -> Any? {
        return self.firstObject
    }
}
