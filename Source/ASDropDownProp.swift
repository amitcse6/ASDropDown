//
//  ASDropDownProp.swift
//  ASDropDown
//
//  Created by Amit on 15/7/20.
//

import Foundation

public class ASDropDownProp: NSObject {
    var font: UIFont?
    var textColor: UIColor?
    
    public override init() {
    }
    
    public init(_ font: UIFont?) {
        self.font = font
    }
    
    public init(_ textColor: UIColor?) {
        self.textColor = textColor
    }
    
    public init(_ font: UIFont?, _ textColor: UIColor?) {
        self.font = font
        self.textColor = textColor
    }
}
