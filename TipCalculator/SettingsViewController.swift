//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Benny Singer on 12/19/16.
//  Copyright © 2016 Singer. All rights reserved.
//

import UIKit

protocol SendBack {
    func setSettingsData(rate0: Double, rate1: Double, rate2: Double, pickedCurrency: String)
}

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var rate0: UITextField!
    @IBOutlet weak var rate1: UITextField!
    @IBOutlet weak var rate2: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var border: UILabel!
    @IBOutlet weak var border0: UILabel!
    @IBOutlet weak var border1: UILabel!
    @IBOutlet weak var borderThin: UILabel!
    @IBOutlet weak var borderThin1: UILabel!
    @IBOutlet weak var border0Rate1: UILabel!
    @IBOutlet weak var border1Rate1: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var delegate:SendBack?
    
    var rate0Double = 18.0
    var rate1Double = 20.0
    var rate2Double = 25.0
    
    var saved = true
    
    let defaultBlue = UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1)
    
    var pickerData: [String] = [String]()
    var pickedCurrency = "$"    
    
    @IBAction func editingRate0(_ sender: Any) {
        editingRate(rate0)
    }
    
    @IBAction func editingRate1(_ sender: Any) {
        editingRate(rate1)
    }
    
    @IBAction func editingRate2(_ sender: Any) {
        editingRate(rate2)
    }

    func editingRate(_ rate: UITextField) {
        resetEditing()
        
        if (rate === rate0) {
            border0.backgroundColor = defaultBlue
            border1.backgroundColor = UIColor.white
            rate.layer.cornerRadius = 5
        }
        else if (rate === rate1) {
            border0Rate1.backgroundColor = defaultBlue
            border1Rate1.backgroundColor = defaultBlue
            rate.layer.cornerRadius = 0
        }
        else if (rate === rate2) {
            border0.backgroundColor = UIColor.white
            border1.backgroundColor = defaultBlue
            rate.layer.cornerRadius = 5
        }
        
        rate.textColor = UIColor.white
        rate.backgroundColor = defaultBlue
        //make cursor white...?
    }
    
    func resetEditing() {
        
        if (!saved) {
            saveButton.isEnabled = true
        }
        else {
            saveButton.isEnabled = false
        }
        
        rate0.backgroundColor = UIColor.white
        rate1.backgroundColor = UIColor.white
        rate2.backgroundColor = UIColor.white
        
        rate0.textColor = rate0.textColor == UIColor.red ? rate0.textColor : defaultBlue
        rate1.textColor = rate1.textColor == UIColor.red ? rate1.textColor : defaultBlue
        rate2.textColor = rate2.textColor == UIColor.red ? rate2.textColor : defaultBlue
        
        rate0.layer.cornerRadius = 8
        rate1.layer.cornerRadius = 8
        rate2.layer.cornerRadius = 8
        
        border0.backgroundColor = UIColor.white
        border1.backgroundColor = UIColor.white
        
        border0Rate1.backgroundColor = UIColor.white
        border1Rate1.backgroundColor = UIColor.white
        
        rate0.selectedTextRange = nil
        rate1.selectedTextRange = nil
        rate2.selectedTextRange = nil
    }
    
    @IBAction func rate0Changed(_ sender: Any) {
        rate0Double = Double(rate0.text!) ?? 0
        //rateBackgroundChanged(rate0)
        rateChanged()
    }
    @IBAction func rate1Changed(_ sender: Any) {
        rate1Double = Double(rate1.text!) ?? 0
        //rateBackgroundChanged(rate1)
        rateChanged()
    }
    @IBAction func rate2Changed(_ sender: Any) {
        rate2Double = Double(rate2.text!) ?? 0
        //rateBackgroundChanged(rate2)
        rateChanged()
    }

    func rateChanged() {
        if (rate0Double != 18.0) || (rate1Double != 20.0) || (rate2Double != 25.0) {
            settingsLabel.text = "Custom Rates"
            settingsLabel.textColor = UIColor.red
            resetButton.isEnabled = true
            saved = false
            saveButton.isEnabled = true
        }
        else {
            settingsLabel.text = "Default Rates"
            settingsLabel.textColor = UIColor.black
            resetButton.isEnabled = false
            saveButton.isEnabled = false
        }
    }
    
    func rateBackgroundChanged(_ rate: UITextField) {
        if (rate === rate0) {
            border0.backgroundColor = UIColor.red
        }
        else if (rate === rate1) {
            border0.backgroundColor = UIColor.red
            border1.backgroundColor = UIColor.red
        }
        else if (rate === rate2) {
            border1.backgroundColor = UIColor.red
        }
    
        rate.backgroundColor = UIColor.red
        //make cursor white...?
    }
    
    @IBAction func rate0EndedEditing(_ sender: Any) {
        if (rate0Double != 18.0) {
            rate0.textColor = UIColor.red
        }
        else {
            rate0.textColor = defaultBlue
        }
    }
    @IBAction func rate1EndedEditing(_ sender: Any) {
        if (rate1Double != 20.0) {
            rate1.textColor = UIColor.red
        }
        else {
            rate1.textColor = defaultBlue
        }
    }
    @IBAction func rate2EndedEditing(_ sender: Any) {
        if (rate2Double != 25.0) {
            rate2.textColor = UIColor.red
        }
        else {
            rate2.textColor = defaultBlue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rate0.text = "\(Int(rate0Double))"
        rate1.text = "\(Int(rate1Double))"
        rate2.text = "\(Int(rate2Double))"
        rateChanged()
        
        border.layer.borderWidth = 1.0
        border.layer.cornerRadius = 8
        border.layer.borderColor = defaultBlue.cgColor
        
        borderThin.backgroundColor = defaultBlue
        borderThin1.backgroundColor = defaultBlue
        
        resetEditing()
        
        rate0EndedEditing(self)
        rate1EndedEditing(self)
        rate2EndedEditing(self)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerData = ["$", "€", "£", "₣", "¤", "؋", "Ar", "Ƀ", "฿", "B/.", "Br", "Bs.", "Bs.F.", "Gh¢", "Ch", "₡", "C$", "D", "ден", "دج" , ".د.ب", "د.ع", "JD", "د.ك", "ل.د", "дин", "د.ت", "د.م.", "د.إ", "Db", "₫", "Esc", "ƒ", "Ft", "FBu", "FCFA", "CFA", "Fr", "FRw", "G", "gr", "₲", "h", "₴", "₭", "Kč", "kr", "kn", "MK", "ZK", "Kz", "K", "L", "Le", "лв", "E", "lp", "₺", "M", "KM", "MT", "Nfk", "₦", "Nu.", "UM", "T$", "MOP$", "₱", "Pt.", "ج.م.", "LL", "LS", "P", "Q", "q", "R", "R$", "ر.ع.", "ر.ق", "ر.س", "៛", "RM", "₽", "Rf.", "₹", "Rs", "SRe", "Rp", "₪", "Ksh", "Sh.So.", "USh", "S/", "сом", "৳", "WS$", "₸", "₮", "VT", "₩", "¥", "zł"]
        
        pickerView.selectRow(pickerData.index(of: pickedCurrency)!, inComponent: 0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerData[row] != pickedCurrency) {
            pickedCurrency = pickerData[row]
            saved = false
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        rate0Double = 18.0
        rate1Double = 20.0
        rate2Double = 25.0
        rate0.text = "\(Int(rate0Double))"
        rate1.text = "\(Int(rate1Double))"
        rate2.text = "\(Int(rate2Double))"
        rate0.textColor = defaultBlue
        rate1.textColor = defaultBlue
        rate2.textColor = defaultBlue
        rateChanged()
        saved = false
        resetEditing()
    }

    @IBAction func saved(_ sender: Any) {
        view.endEditing(true)
        saved = true
        resetEditing()
        rate0Double = Double(rate0.text!) ?? 0
        rate1Double = Double(rate1.text!) ?? 0
        rate2Double = Double(rate2.text!) ?? 0
        delegate?.setSettingsData(rate0: rate0Double, rate1: rate1Double, rate2: rate2Double, pickedCurrency: pickedCurrency)
    }
    
    /*@IBAction func touchedRate0(_ sender: Any) {
        rate0.tintColor = UIColor.blue
        rate0.selectedTextRange = rate0.textRange(from: rate0.beginningOfDocument, to: rate0.endOfDocument)
    }*/
    
    @IBAction func onTap(_ sender: Any) {
        if (saved) {
            view.endEditing(true)
            resetEditing()
        }
    }
}
