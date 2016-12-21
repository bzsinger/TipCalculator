//
//  ViewController.swift
//  TipCalc
//
//  Created by Benny Singer on 12/16/16.
//  Copyright © 2016 Singer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SendBack {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var separationBar: UIView!
    let defaultBlue = UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1)
    
    var tipPercentages = [0.18, 0.2, 0.25]
    var currency = "$"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        separationBar.backgroundColor = defaultBlue
        billField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateTip() {
        let bill = Double(billField.text!) ?? 0
        //if text cast to Double returns nil, set val to 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        if (currency == "$" || currency == "€" || currency == "£") {
            tipLabel.text = /*"$\(tip)"*/ String(format: "%@%.2f", currency, tip)
            totalLabel.text = String(format: "%@%.2f", currency, total)
        }
        else {
            tipLabel.text = /*"$\(tip)"*/ String(format: "%.2f%@",  tip, currency)
            totalLabel.text = String(format: "%.2f%@", total, currency)
        }
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func getSettings(_ sender: Any) {
        let settingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        settingsViewController.delegate = self
        
        settingsViewController.rate0Double = tipPercentages[0] * 100
        settingsViewController.rate1Double = tipPercentages[1] * 100
        settingsViewController.rate2Double = tipPercentages[2] * 100
        
        settingsViewController.pickedCurrency = currency
        
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @IBAction func clear(_ sender: Any) {
        billField.text = ""
        calculateTip()
    }
    
    func setSettingsData(rate0: Double, rate1: Double, rate2: Double, pickedCurrency: String) {
        tipControl.setTitle("\(Int(rate0))%", forSegmentAt: 0)
        tipControl.setTitle("\(Int(rate1))%", forSegmentAt: 1)
        tipControl.setTitle("\(Int(rate2))%", forSegmentAt: 2)
            
        tipPercentages[0] = rate0 * 0.01
        tipPercentages[1] = rate1 * 0.01
        tipPercentages[2] = rate2 * 0.01
        
        currency = pickedCurrency
        
        calculateTip()
    }
}

