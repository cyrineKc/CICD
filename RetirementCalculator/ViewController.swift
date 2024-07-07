//
//  ViewController.swift
//  RetirementCalculator
//
//  Created by Cyrine Kchir on 02.07.24.
//

import UIKit
import AppCenterCrashes
import AppCenterAnalytics
import AppCenter

class ViewController: UIViewController {
    
    @IBOutlet weak var monthyInvestTextField: UITextField!
    @IBOutlet weak var currentAgeTextField: UITextField!
    @IBOutlet weak var plannedRetiringAgeTextField: UITextField!
    @IBOutlet weak var avergeInterestTextField: UITextField!
    @IBOutlet weak var savingsTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        //Crashes.generateTestCrash()
        let currentAgeText = currentAgeTextField.text!
        let plannedRetiringAgeText = plannedRetiringAgeTextField.text!
        let properties = ["current Age" : currentAgeText, "planned retiring age": plannedRetiringAgeText ]
        resultLabel.text = "If you save $\(monthyInvestTextField.text!) every month for \(plannedRetiringAgeTextField.text!) years, and invest that money plus your current investment of $\(savingsTextField.text!) at a \(avergeInterestTextField.text!)% anual interest rate, you will have $\(savingsTextField.text) by the time you are \(plannedRetiringAgeTextField.text!) years old."
        Analytics.trackEvent("calculate Button tap", withProperties: properties)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        Analytics.trackEvent("calculater view appears")
        if Crashes.hasCrashedInLastSession {
            let alert = UIAlertController(title: "Oops" , message: "An Error occured" , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "It is cool", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}

