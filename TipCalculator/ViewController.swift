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
    var tipPercentages = [0.18, 0.2, 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true); //true - forced down keyboard
    }
    
    func calculateTip() {
        let bill = Double(billField.text!) ?? 0
        //if text cast to Double returns nil, set val to 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = /*"$\(tip)"*/ String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
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
        
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func setSettingsData(rate0: Double, rate1: Double, rate2: Double) {
        tipControl.setTitle("\(Int(rate0))%", forSegmentAt: 0)
        tipControl.setTitle("\(Int(rate1))%", forSegmentAt: 1)
        tipControl.setTitle("\(Int(rate2))%", forSegmentAt: 2)
            
        tipPercentages[0] = rate0 * 0.01
        tipPercentages[1] = rate1 * 0.01
        tipPercentages[2] = rate2 * 0.01
        
        calculateTip()
    }
}

