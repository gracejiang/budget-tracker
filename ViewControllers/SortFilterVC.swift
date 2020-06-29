//
//  SortFilterVC.swift
//  Budget
//
//  Created by Grace Jiang on 8/11/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import UIKit

class SortFilterVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var sortPicker: UIPickerView!
    @IBOutlet weak var foodSwitch: UISwitch!
    @IBOutlet weak var drinksSwitch: UISwitch!
    @IBOutlet weak var entertainmentSwitch: UISwitch!
    @IBOutlet weak var shoppingSwitch: UISwitch!
    @IBOutlet weak var transportSwitch: UISwitch!
    @IBOutlet weak var miscSwitch: UISwitch!
    @IBOutlet weak var startDateSwitch: UISwitch!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    
    
    var sortOptions: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sortPicker.delegate = self
        self.sortPicker.dataSource = self
        sortOptions = ["Date ASC", "Date DESC", "Category"]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        foodSwitch.setOn(CategoryManager.filteredValues["food"] ?? true, animated: false)
        drinksSwitch.setOn(CategoryManager.filteredValues["drinks"] ?? true, animated: false)
        entertainmentSwitch.setOn(CategoryManager.filteredValues["entertainment"] ?? true, animated: false)
        shoppingSwitch.setOn(CategoryManager.filteredValues["shopping"] ?? true, animated: false)
        transportSwitch.setOn(CategoryManager.filteredValues["transportation"] ?? true, animated: false)
        miscSwitch.setOn(CategoryManager.filteredValues["misc"] ?? true, animated: false)
    }
    

    
    func filterOn() -> [String: Bool] {
        CategoryManager.filteredValues["food"] = foodSwitch.isOn
        CategoryManager.filteredValues["drinks"] = drinksSwitch.isOn
        CategoryManager.filteredValues["entertainment"] = entertainmentSwitch.isOn
        CategoryManager.filteredValues["shopping"] = shoppingSwitch.isOn
        CategoryManager.filteredValues["transportation"] = transportSwitch.isOn
        CategoryManager.filteredValues["misc"] = miscSwitch.isOn
        return CategoryManager.filteredValues
    }
    
    
    @IBAction func selectAllPressed(_ sender: Any) {
        foodSwitch.setOn(true, animated: true)
        drinksSwitch.setOn(true, animated: true)
        entertainmentSwitch.setOn(true, animated: true)
        shoppingSwitch.setOn(true, animated: true)
        transportSwitch.setOn(true, animated: true)
        miscSwitch.setOn(true, animated: true)
    }
    
    @IBAction func deselectAllPressed(_ sender: Any) {
        foodSwitch.setOn(false, animated: true)
        drinksSwitch.setOn(false, animated: true)
        entertainmentSwitch.setOn(false, animated: true)
        shoppingSwitch.setOn(false, animated: true)
        transportSwitch.setOn(false, animated: true)
        miscSwitch.setOn(false, animated: true)
    }
    
    @IBAction func startDatePressed(_ sender: Any) {
        if startDateSwitch.isOn {
            startDatePicker.alpha = 1
            startDatePicker.isUserInteractionEnabled = true
        } else {
            startDatePicker.date = Date()
            startDatePicker.alpha = 0.3
            startDatePicker.isUserInteractionEnabled = false
        }
    }
    
    
    
    
    @IBAction func submitAction(_ sender: Any) {
        // update date asc (0), date desc (1), category (2)
        BlobsVC.updateSortBy(option: sortPicker.selectedRow(inComponent: 0))
        BlobManager.filterBlobs(onValues: filterOn())
    }
    
    
    
    
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOptions[row]
    }

}
