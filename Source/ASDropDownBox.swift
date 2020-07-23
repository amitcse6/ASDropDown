//
//  ASDropBox.swift
//  superapp
//
//  Created by Amit on 11/7/20.
//  Copyright © 2020 Amit. All rights reserved.
//

import Foundation

public typealias ASDropDownBoxIndex = Int
public typealias ASDropDownBoxClosure = (ASDropDownBoxIndex, String) -> Void

@available(iOS 9.0, *)
public class ASDropDownBox: UIView {
    internal var selectionAction: ASDropDownBoxClosure?
    
    internal var container: UIView?
    internal var body: UIView?
    internal var myScrollView: UIScrollView?
    internal var myStackView: UIStackView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    public func setup() {
        setupUIElements()
        setupConstraints()
    }
    
    public func setupUIElements() {
        container = UIView()
        addSubview(container.unsafelyUnwrapped)
        container?.backgroundColor = .clear
        
        self.body = UIView()
        self.container?.addSubview(self.body.unsafelyUnwrapped)
        self.body?.backgroundColor = .clear
        
        self.myScrollView = UIScrollView()
        self.body?.addSubview(self.myScrollView.unsafelyUnwrapped)
        self.myScrollView?.isUserInteractionEnabled = true
        self.myScrollView?.backgroundColor = .clear
        self.myScrollView?.showsHorizontalScrollIndicator = false
        self.myScrollView?.showsVerticalScrollIndicator = false
        self.myScrollView?.bounces=true
        self.myScrollView?.isScrollEnabled=true
        self.myScrollView?.bounces = true
        self.myScrollView?.bouncesZoom = true
        self.myScrollView?.alwaysBounceVertical = true
        
        self.myStackView = UIStackView()
        self.myScrollView?.addSubview(self.myStackView.unsafelyUnwrapped)
        self.myStackView?.backgroundColor = .clear
        self.myStackView?.axis = .vertical
    }
    
    public func setupConstraints() {
        container?.translatesAutoresizingMaskIntoConstraints = false
        container?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        container?.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        container?.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        container?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        self.body?.translatesAutoresizingMaskIntoConstraints = false
        self.body?.topAnchor.constraint(equalTo: self.container.unsafelyUnwrapped.topAnchor).isActive = true
        self.body?.leftAnchor.constraint(equalTo: self.container.unsafelyUnwrapped.leftAnchor).isActive = true
        self.body?.rightAnchor.constraint(equalTo: self.container.unsafelyUnwrapped.rightAnchor).isActive = true
        self.body?.bottomAnchor.constraint(equalTo: self.container.unsafelyUnwrapped.bottomAnchor).isActive = true
        
        self.myScrollView?.translatesAutoresizingMaskIntoConstraints = false
        self.myScrollView?.topAnchor.constraint(equalTo: self.body.unsafelyUnwrapped.topAnchor).isActive = true
        self.myScrollView?.leftAnchor.constraint(equalTo: self.body.unsafelyUnwrapped.leftAnchor).isActive = true
        self.myScrollView?.rightAnchor.constraint(equalTo: self.body.unsafelyUnwrapped.rightAnchor).isActive = true
        self.myScrollView?.bottomAnchor.constraint(equalTo: self.body.unsafelyUnwrapped.bottomAnchor).isActive = true
        
        self.myStackView?.translatesAutoresizingMaskIntoConstraints = false
        self.myStackView?.topAnchor.constraint(equalTo: self.myScrollView.unsafelyUnwrapped.topAnchor).isActive = true
        self.myStackView?.leftAnchor.constraint(equalTo: self.myScrollView.unsafelyUnwrapped.leftAnchor).isActive = true
        self.myStackView?.rightAnchor.constraint(equalTo: self.myScrollView.unsafelyUnwrapped.rightAnchor).isActive = true
        self.myStackView?.bottomAnchor.constraint(equalTo: self.myScrollView.unsafelyUnwrapped.bottomAnchor).isActive = true
        self.myStackView?.widthAnchor.constraint(equalTo: self.myScrollView.unsafelyUnwrapped.widthAnchor).isActive = true
        let heightConstraint = self.myStackView?.heightAnchor.constraint(equalTo: self.myScrollView.unsafelyUnwrapped.heightAnchor)
        heightConstraint?.priority = UILayoutPriority(rawValue: 250)
        heightConstraint?.isActive = true
    }
    
    public func addItems(_ items: [ASDropDownItem]?, _ prop: ASDropDownProp?) {
        if let items = items {
            for (index, item) in items.enumerated() {
                addItem(index, item, prop)
            }
        }
    }
    
    public func addItem(_ index: Int, _ item: ASDropDownItem, _ prop: ASDropDownProp?) {
        let cell = ASDropDownCell(index, item, prop)
        myStackView?.addArrangedSubview(cell)
        cell.delegate = self
        cell.backgroundColor = .clear
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.widthAnchor.constraint(equalTo: self.myStackView.unsafelyUnwrapped.widthAnchor).isActive = true
        let subBackViewHeightConstraint = cell.heightAnchor.constraint(lessThanOrEqualTo: self.myScrollView.unsafelyUnwrapped.heightAnchor)
        subBackViewHeightConstraint.priority = UILayoutPriority(rawValue: 250)
        subBackViewHeightConstraint.isActive = true
        //cell.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

@available(iOS 9.0, *)
extension ASDropDownBox {
    @discardableResult
    func setEvent(_ selectionAction: ASDropDownBoxClosure?) -> ASDropDownBox {
        self.selectionAction = selectionAction
        return self
    }
}

@available(iOS 9.0, *)
extension ASDropDownBox: ASDropDownCellDelegate {
    func selected(_ cell: ASDropDownCell) {
        selectionAction?(cell.index, cell.item?.title ?? "title_\(cell.index)")
    }
}
