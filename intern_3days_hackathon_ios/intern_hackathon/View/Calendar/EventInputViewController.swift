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
    let eventInputViewPresenter = EventInputViewPresenter()
    @IBOutlet weak var finishButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.delegate = self
        placeTextField.delegate = self
        memoTextField.delegate = self
        //setupToolbar()
        
        dateTextField.customToolbar(view: view)
        placeTextField.customToolbar(view: view)
        memoTextField.customToolbar(view: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        textFieldValidate()
    }
    
    @IBAction func closeModal(_ sender: Any) {
        eventInputViewPresenter.addEvent(date: dateTextField.text!, place: placeTextField.text!, memo: memoTextField.text!)
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
        datePicker.locale = Locale(identifier: "ja")
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
        dateFormatter.dateFormat  = "YYYY/M/d"
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func doneBtn() {
        dateTextField.resignFirstResponder()
    }
    
    func textFieldValidate() {
        guard let dateTextData = dateTextField.text else {
            self.finishButton.isEnabled = false
            return
        }
        guard let placeTextData = placeTextField.text else {
            self.finishButton.isEnabled = false
            return
        }
        guard let memoTextData = memoTextField.text else {
            self.finishButton.isEnabled = false
            return
        }
        
        if dateTextData.isEmpty {
            self.finishButton.isEnabled = false
        } else {
            self.finishButton.isEnabled = true
        }
        
        if placeTextData.isEmpty {
            self.finishButton.isEnabled = false
        } else {
            self.finishButton.isEnabled = true
        }
        
        if memoTextData.isEmpty {
            self.finishButton.isEnabled = false
        } else {
            self.finishButton.isEnabled = true
        }
    }
}
