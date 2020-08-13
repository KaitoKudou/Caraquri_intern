//
//  EventInputViewController.swift
//  intern_hackathon
//
//  Created by 工藤海斗 on 2020/08/13.
//  Copyright © 2020 caraquri. All rights reserved.
//

import UIKit

class EventInputViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    var eventInputViewPresenter: EventInputViewPresenter!
    var date: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.delegate = self
        placeTextField.delegate = self
        memoTextField.delegate = self
        //setupToolbar()
    }
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*func setupToolbar() {
        //datepicker上のtoolbarのdoneボタン
        let toolBar: UIToolbar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(doneBtn))
        toolBar.items = [toolBarBtn]
        dateTextField.inputAccessoryView = toolBar
    }*/
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        placeTextField.resignFirstResponder()
        memoTextField.resignFirstResponder()
        return true
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "MM/dd"
        dateTextField.text = dateFormatter.string(from: sender.date)
        print(dateFormatter.string(from: sender.date))
        date = dateFormatter.string(from: sender.date)
    }
    
    @objc func doneBtn() {
        dateTextField.resignFirstResponder()
    }
}
