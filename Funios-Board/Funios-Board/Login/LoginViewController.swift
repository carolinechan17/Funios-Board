//
//  LoginViewController.swift
//  Funios-Board
//
//  Created by Ade Dwi Prayitno on 28/07/22.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var cardView: UIView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    @IBAction func signUpButton(_ sender: Any) {
        print("ini SignUp")
    }
    @IBAction func loginButton(_ sender: Any) {
        if(emailTextField.hasText && passwordTextField.hasText){
            print("User Login: \n email:\(emailTextField.text) \n password: \(passwordTextField.text)")
        }else{
            print("Membutuhkan Password & Email")
        }
    }
    @IBAction func forgotPasswordButton(_ sender: Any) {
        print("ini lupa password")
    }
}

//MARK: - Setup Layout
extension LoginViewController{
    func setupLayout(){
        //CardView
        cardView.layer.cornerRadius = 35
        
        //EmailTextView
        emailTextField.textContentType = .emailAddress
        addTextFieldAttributes(hint: "Enter your e-mail",
                               icon: UIImage(systemName: "envelope") ?? UIImage(systemName: "questionmark.app")!,
                               to: emailTextField)
        //Password
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        addTextFieldAttributes(hint: "Enter your password",
                               icon: UIImage(systemName: "lock") ?? UIImage(systemName: "questionmark.app")!,
                               to: passwordTextField)
    }
    
    func addTextFieldAttributes(hint placeHolder: String, icon: UIImage, to textField: UITextField){
        textField.placeholder = placeHolder
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: icon.size.width, height: icon.size.height))
        leftImageView.image = icon
        textField.leftView = leftImageView
        textField.leftView?.tintColor = UIColor.systemGray3
        textField.leftViewMode = .always
    }
}
