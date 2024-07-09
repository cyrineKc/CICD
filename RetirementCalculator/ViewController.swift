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
    
    func calculateRetirementAmount(current_age: Int, retirement_age : Int, monthly_investment: Float, current_savings: Float, interest_rate: Float) -> Double {
        let months_until_retirement = (retirement_age - current_age) * 12
        
        var retirement_amount = Double(current_savings) * pow(Double(1+interest_rate/100), Double(months_until_retirement))
        
        for i in 1...months_until_retirement {
            let monthly_rate = interest_rate / 100 / 12
            retirement_amount += Double(monthly_investment) * pow(Double(1+monthly_rate), Double(i))
        }
        
        return retirement_amount
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        //Crashes.generateTestCrash()
        let current_age : Int? = Int(currentAgeTextField.text!)
        let planned_retirement_age : Int? = Int(plannedRetiringAgeTextField.text!)
        let monthly_investment : Float? = Float(monthyInvestTextField.text!)
        let current_savings : Float? = Float(savingsTextField.text!)
        let interest_rate : Float? = Float(avergeInterestTextField.text!)
        
        let retirement_amount = calculateRetirementAmount(current_age: current_age!, retirement_age: planned_retirement_age!, monthly_investment: monthly_investment!, current_savings: current_savings!, interest_rate: interest_rate!)
        
        resultLabel.text = "If you save $\(monthly_investment!) every month for \(planned_retirement_age! - current_age!) years, and invest that money plus your current investment of $\(current_savings!) at a \(interest_rate!)% anual interest rate, you will have $\(retirement_amount) by the time you are \(planned_retirement_age!)"
        
        let properties = ["current_age": String(current_age!),
                          "planned_retirement_age": String(planned_retirement_age!)]
        
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

