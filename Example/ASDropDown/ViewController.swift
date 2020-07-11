//
//  ViewController.swift
//  ASDropDown
//
//  Created by amitpstu1@gmail.com on 07/11/2020.
//  Copyright (c) 2020 amitpstu1@gmail.com. All rights reserved.
//

import UIKit
import ASDropDown

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func dropdownEvent(_ sender: Any) {
        let items = (0..<100).map({return ASDropDownItem(key: "key_\($0)", title: "item-\($0)")})
        ASDropDown.openDropDown(items, { [unowned self] (index: Int, item: String) in
            self.textField.text = item
            }, button, nil)
    }
}

