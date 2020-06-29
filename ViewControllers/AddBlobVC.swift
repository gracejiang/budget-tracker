//
//  AddBlobVC.swift
//  Budget
//
//  Created by Grace Jiang on 8/11/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import UIKit

class AddBlobVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesTextField: UITextField!
    
    var categoryData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        categoryData = ["Food", "Drinks", "Entertainment", "Shopping", "Transportation", "Misc"]

        amountTextField.keyboardType = .decimalPad
        
        // Do any additional setup after loading the view.
    }
    
    func checkValid() -> Bool {
        return (nameTextField.text != "") && (amountTextField.text != "")
    }
    
    @IBAction func submitBlob(_ sender: Any) {
        
        if !checkValid() {
            print("not valid")
            Functions.alertUser(vc: self, title: "Invalid Blob", message: "Please make sure all the fields are filled out correctly.")
            return
        }
        
        let name : String = nameTextField.text ?? ""
        let amount : Double = Double(amountTextField.text!) ?? 0.00
        let date : Date = datePicker.date
        var category : Category
        let note : String = notesTextField.text ?? ""
        
        switch categoryPicker.selectedRow(inComponent: 0) {
        case 0:
            category = CategoryManager.getCategory(name: "food")
        case 1:
            category = CategoryManager.getCategory(name: "drinks")
        case 2:
            category = CategoryManager.getCategory(name: "entertainment")
        case 3:
            category = CategoryManager.getCategory(name: "shopping")
        case 4:
            category = CategoryManager.getCategory(name: "transportation")
        case 5:
            category = CategoryManager.getCategory(name: "misc")
        default:
            category = CategoryManager.getCategory(name: "uncategorized")
        }
        
        BlobManager.addBlob(name: name, date: date, amount: amount, cat: category, note: note)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return categoryData[row]
    }
    
}
