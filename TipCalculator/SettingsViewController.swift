//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Benny Singer on 12/19/16.
//  Copyright © 2016 Singer. All rights reserved.
//

import UIKit

protocol SendBack {
    func setSettingsData(rate0: Double, rate1: Double, rate2: Double)
}

class SettingsViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var rate0: UITextField!
    @IBOutlet weak var rate1: UITextField!
    @IBOutlet weak var rate2: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    var rate0Double = 18.0
    var rate1Double = 20.0
    var rate2Double = 25.0
    
    @IBOutlet weak var settingsLabel: UILabel!
    
    var delegate:SendBack?
    
    @IBAction func rate0Changed(_ sender: Any) {
        rate0Double = Double(rate0.text!) ?? 0
        rateChanged()
    }
    @IBAction func rate1Changed(_ sender: Any) {
        rate1Double = Double(rate1.text!) ?? 0
        rateChanged()
    }
    @IBAction func rate2Changed(_ sender: Any) {
        rate2Double = Double(rate2.text!) ?? 0
        rateChanged()
    }
    
    func rateChanged() {
        if (rate0Double != 18.0) || (rate1Double != 20.0) || (rate2Double != 25.0) {
            settingsLabel.text = "Custom Rates"
            settingsLabel.textColor = UIColor.red
            resetButton.isEnabled = true
        }
        else {
            settingsLabel.text = "Default Rates"
            settingsLabel.textColor = UIColor.black
            resetButton.isEnabled = false
        }
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rate0.text = "\(Int(rate0Double))"
        rate1.text = "\(Int(rate1Double))"
        rate2.text = "\(Int(rate2Double))"
        rateChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        rate0Double = 18.0
        rate1Double = 20.0
        rate2Double = 25.0
        rate0.text = "\(Int(rate0Double))"
        rate1.text = "\(Int(rate1Double))"
        rate2.text = "\(Int(rate2Double))"
        rateChanged()
    }
    
    @IBAction func saved(_ sender: Any) {
        view.endEditing(true)
        rate0Double = Double(rate0.text!) ?? 0
        rate1Double = Double(rate1.text!) ?? 0
        rate2Double = Double(rate2.text!) ?? 0
        delegate?.setSettingsData(rate0: rate0Double, rate1: rate1Double, rate2: rate2Double)
    }
}
