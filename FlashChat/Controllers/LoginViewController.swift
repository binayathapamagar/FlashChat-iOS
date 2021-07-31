//
//  LoginViewController.swift
//  FlashChat
//
//  Created by Binaya on 27/07/2021.
//

import UIKit
import Firebase
import JHSpinner

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var spinner = JHSpinnerView()
    
    
    //MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
       
    override func viewDidDisappear(_ animated: Bool) {
        
        spinner.dismiss()
        
    }
    

    //MARK: - IBAction methods

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        showSpinner()
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in

                if let e = error {
                    
                    self.spinner.dismiss()
                    
                    if email == "" && password == "" {
                        
                        self.displayErrorAlert(with: "Both fields are required!")
                        
                    }else {
                        
                        self.displayErrorAlert(with: e.localizedDescription)
                        
                    }
                    
                }else {
                    
                    self.performSegue(withIdentifier: K.loginSegueIdentifier, sender: self)
                    
                }
                
            }
            
        }
        
    }
    
    //MARK: - Instance Methods
    
    func displayErrorAlert(with error: String) {
        
        let alert = UIAlertController(title: "ERROR", message: error, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showSpinner() {
        
        self.spinner = JHSpinnerView.showOnView(self.view, spinnerColor:UIColor(red: 0.09, green: 0.86, blue: 1.00, alpha: 1.00), overlay:.circular, overlayColor:UIColor.black.withAlphaComponent(0.6))
                
        self.view.addSubview(self.spinner)
        
    }

}
