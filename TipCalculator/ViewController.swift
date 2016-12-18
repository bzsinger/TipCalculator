//
//  ViewController.swift
//  TipCalc
//
//  Created by Benny Singer on 12/16/16.
//  Copyright © 2016 Singer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true); //true - forced down keyboard
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = [0.18, 0.2, 0.25];
        
        let bill = Double(billField.text!) ?? 0
        //if text cast to Double returns nil, set val to 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = /*"$\(tip)"*/ String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)

    }

    
}

