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
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var rate0: UITextField!
    @IBOutlet weak var rate1: UITextField!
    @IBOutlet weak var rate2: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var border: UILabel!
    @IBOutlet weak var border0: UILabel!
    @IBOutlet weak var border1: UILabel!
    
    var delegate:SendBack?
    
    var rate0Double = 18.0
    var rate1Double = 20.0
    var rate2Double = 25.0
    
    var saved = true
    
    let defaultBlue = UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1)
    
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
            border0.backgroundColor = defaultBlue
            border1.backgroundColor = defaultBlue
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
    }
    
    @IBAction func rate0Changed(_ sender: Any) {
        rate0Double = Double(rate0.text!) ?? 0
        rateBackgroundChanged(rate0)
        rateChanged()
    }
    @IBAction func rate1Changed(_ sender: Any) {
        rate1Double = Double(rate1.text!) ?? 0
        rateBackgroundChanged(rate1)
        rateChanged()
    }
    @IBAction func rate2Changed(_ sender: Any) {
        rate2Double = Double(rate2.text!) ?? 0
        rateBackgroundChanged(rate2)
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
        
        resetEditing()
        
        rate0EndedEditing(self)
        rate1EndedEditing(self)
        rate2EndedEditing(self)
        
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
        delegate?.setSettingsData(rate0: rate0Double, rate1: rate1Double, rate2: rate2Double)
    }
    
    @IBAction func onTap(_ sender: Any) {
        if (saved) {
            view.endEditing(true)
            resetEditing()
        }
    }
}
