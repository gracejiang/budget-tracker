//
//  LoginVC.swift
//  Budget
//
//  Created by Grace Jiang on 8/8/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//


import UIKit
import Firebase
import FirebaseUI

class LoginVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var validUser : Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleLoginView()
        passwordTextField.isSecureTextEntry = true
        
        loginButton.layer.cornerRadius = 5
        registerButton.layer.cornerRadius = 5
        segControl.layer.cornerRadius = 5
        
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        if segControl.selectedSegmentIndex == 0 {
            handleLoginView()
        } else {
            handleRegisterView()
        }
    }
    
    func handleLoginView() {
        loginButton.isHidden = false
        registerButton.isHidden = true
        nameTextField.isHidden = true
    }
    
    func handleRegisterView() {
        loginButton.isHidden = true
        registerButton.isHidden = false
        nameTextField.isHidden = false
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                Functions.alertUser(vc: self, title: "Error", message: "Invalid user/password combination. Please try again.")
                return
            }
            
            UserManager.setUpCurrUser {
                CategoryManager.setUpCategories()
                BlobManager.setUpBlobs {
                    self.dismiss(animated: true, completion: nil)
                    self.performSegue(withIdentifier: "goHome", sender: self)
                }
            }

        })
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (res, error) in
            
            if let error = error {
                if (error.localizedDescription == "The email address is badly formatted.") {
                    Functions.alertUser(vc: self, title: "Invalid Email", message: "Please enter a valid email.")
                } else if (error.localizedDescription == "The password must be 6 characters long or more.") {
                    Functions.alertUser(vc: self, title: "Invalid Password", message: "Your password is too short. Please enter a password that is at least 6 characters or more.")
                }
                return
            }
            
            guard let uid = res?.user.uid else {
                return
            }
            
            let ref = Database.database().reference()
            let usersReference = ref.child("users").child(uid)

            let values = ["name": name, "uid" : uid, "email": email]
            
            usersReference.updateChildValues(values, withCompletionBlock: {(err, ref) in })
            
            UserManager.setUpCurrUser {
                CategoryManager.setUpCategories()
                BlobManager.setUpBlobs {
                    self.performSegue(withIdentifier: "goHome", sender: self)
                }
            }
            
        })
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        handleLogin()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        handleRegister()
    }
    
    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension LoginVC: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else {
            return
        }
    }
    
}

