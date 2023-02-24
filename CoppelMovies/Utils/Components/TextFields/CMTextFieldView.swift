//
//  CMUITextField.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


@objc protocol CMTextFieldProtocol: AnyObject {
    func cmTextFieldDidChange(identifier: String, text: String)
    @objc optional func cmTextFieldDonePressed(identifier: String)
}


class CMTextFieldView: UIView {
    weak var delegate: CMTextFieldProtocol?
    var identifier: String = ""
    
    var text: String {
        set {
            textFieldView.text = newValue
        }
        get {
            return textFieldView.text ?? ""
        }
    }

    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private lazy var textFieldView: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        textField.textColor = .black
        
        return textField
    }()
    
    
    init(placeholder: String = "", isSecure: Bool = false, delegate: CMTextFieldProtocol? = nil, identifier: String = "") {
        super.init(frame: .zero)
        
        self.setUI()
        self.setConstraints()
        
        textFieldView.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.cmLightGray])
        textFieldView.isSecureTextEntry = isSecure
        textFieldView.delegate = self
        textFieldView.returnKeyType = .done
        
        self.delegate = delegate
        self.identifier = identifier
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        self.addSubview(containerView)
        containerView.addSubview(textFieldView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            textFieldView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            textFieldView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            textFieldView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            textFieldView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -0),
            textFieldView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func makeFirstResponder() {
        textFieldView.becomeFirstResponder()
    }
    
    func dropFirstResponder() {
        textFieldView.resignFirstResponder()
    }
    
    @objc func textfieldDidChange() {
        self.delegate?.cmTextFieldDidChange(identifier: self.identifier, text: self.text)
    }
}


extension CMTextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.delegate?.cmTextFieldDonePressed?(identifier: self.identifier)
        return true
    }
}
