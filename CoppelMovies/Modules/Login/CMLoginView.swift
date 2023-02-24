//
//  CMLoginView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMLoginViewProtocol: AnyObject {
    var presenter: CMLoginPresenterProtocol? { get set }
    
    func notifyGetNavigation() -> UINavigationController?
    
    func notifyError(message: String)
}

class CMLoginView: UIViewController, CMLoginViewProtocol {
    var presenter: CMLoginPresenterProtocol?
    
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var componentsContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var usernameTextView: CMTextFieldView = {
       let textView = CMTextFieldView(placeholder: "Username", delegate: self, identifier: "username")
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var credentialTextView: CMTextFieldView = {
       let textView = CMTextFieldView(placeholder: "Password", isSecure: true, delegate: self, identifier: "credential")
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var loginButton: CMButtonView = {
        let button = CMButtonView(title: "Log in", enabled: false)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.action = loginButtonTriggered
        
        return button
    }()
    
    lazy var loginErrorLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cmDarkRed
        label.isHidden = true
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        
        return label
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConstraints()
        
        usernameTextView.text = "luisdiaztest"
        credentialTextView.text = "Hola_123"
    }
    
    
    private func setUI(){
        view.addSubview(containerView)
        
        containerView.addSubview(componentsContainerView)
        
        componentsContainerView.addSubview(usernameTextView)
        componentsContainerView.addSubview(credentialTextView)
        componentsContainerView.addSubview(loginButton)
        componentsContainerView.addSubview(loginErrorLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            componentsContainerView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: .dimen20),
            componentsContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .dimen60),
            componentsContainerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            componentsContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.dimen60),
            componentsContainerView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -.dimen20),
            
            usernameTextView.topAnchor.constraint(equalTo: componentsContainerView.topAnchor),
            usernameTextView.leadingAnchor.constraint(equalTo: componentsContainerView.leadingAnchor),
            usernameTextView.trailingAnchor.constraint(equalTo: componentsContainerView.trailingAnchor),
            
            credentialTextView.topAnchor.constraint(equalTo: usernameTextView.bottomAnchor, constant: .dimen20),
            credentialTextView.leadingAnchor.constraint(equalTo: componentsContainerView.leadingAnchor),
            credentialTextView.trailingAnchor.constraint(equalTo: componentsContainerView.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: credentialTextView.bottomAnchor, constant: .dimen20),
            loginButton.leadingAnchor.constraint(equalTo: componentsContainerView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: componentsContainerView.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: componentsContainerView.bottomAnchor),
            
            loginErrorLabel.topAnchor.constraint(equalTo: componentsContainerView.bottomAnchor, constant: .dimen20),
            loginErrorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .dimen20),
            loginErrorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.dimen20),
        ])
    }
    
    
    func loginButtonTriggered() {
        credentialTextView.dropFirstResponder()
        usernameTextView.dropFirstResponder()
        
        guard ((!usernameTextView.text.isEmpty && !credentialTextView.text.isEmpty) && loginButton.enabled) else {
            return
        }
        
        loginErrorLabel.isHidden = true
        loginErrorLabel.text = ""
        loginButton.enabled = false
        
        self.presenter?.requestLogin(username: usernameTextView.text, credential: credentialTextView.text)
    }
    
    func notifyGetNavigation() -> UINavigationController? {
        return self.navigationController
    }
    
    func notifyError(message: String){
        self.loginErrorLabel.text = message
        self.loginErrorLabel.isHidden = false
    }
}


extension CMLoginView: CMTextFieldProtocol {
    func cmTextFieldDidChange(identifier: String, text: String) {
        loginButton.enabled = (!usernameTextView.text.isEmpty && !credentialTextView.text.isEmpty)
    }
    
    func cmTextFieldDonePressed(identifier: String) {
        if usernameTextView.identifier == identifier {
            credentialTextView.makeFirstResponder()
        } else if credentialTextView.identifier == identifier {
            loginButtonTriggered()
        }
    }
}
