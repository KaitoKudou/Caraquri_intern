//
//  Keyboad+Extensions.swift
//  intern_hackathon
//
//  Created by 神野成紀 on 2020/08/13.
//  Copyright © 2020 caraquri. All rights reserved.
//

import UIKit

extension UITextField {
    func customToolbar(view: UIView) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let okButton = UIBarButtonItem(title: "完了", style: UIBarButtonItem.Style.done, target: self, action: #selector(tappedOkButton))
        toolbar.setItems([flexibleSpace, okButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc func tappedOkButton() {
        self.endEditing(true)
    }
}

extension UISearchBar {
    func customToolbar(view: UIView) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let okButton = UIBarButtonItem(title: "閉じる", style: UIBarButtonItem.Style.done, target: self, action: #selector(tappedOkButton))
        toolbar.setItems([flexibleSpace, okButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc func tappedOkButton() {
        self.endEditing(true)
    }
}
