//
//  CMButtonView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit

enum CMButtonStyle {
    case enabled
    case disabled
    
    func getTitleColor() -> UIColor {
        switch self {
        case .enabled:
            return .white
        case .disabled:
            return .white
        }
    }
    
    func getBackgroundColor() -> UIColor {
        switch self {
        case .enabled:
            return .cmLighGreen
        case .disabled:
            return .cmLightGray
        }
    }
}


class CMButtonView: UIView {
    private var style: CMButtonStyle = .enabled
    var action: (() -> ())?
    
    var enabled: Bool = true {
        didSet{
            style = enabled ? .enabled : .disabled
            setStyle()
        }
    }
    
    var title: String = "" {
        didSet{
            buttonView.setTitle(title, for: .normal)
        }
    }
    
    
    lazy var buttonView: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonTriggered), for: .touchUpInside)
        
        return button
    }()
    
    
    init(title: String, enabled: Bool = true) {
        super.init(frame: .zero)
        
        setUI()
        setConstraints()
        
        self.title = title
        self.style = enabled ? .enabled : .disabled
        setStyle()
        buttonView.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        self.addSubview(buttonView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            buttonView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setStyle() {
        buttonView.setTitleColor(style.getTitleColor(), for: .normal)
        buttonView.backgroundColor = style.getBackgroundColor()
        
        buttonView.isUserInteractionEnabled = style == .enabled
    }
    
    
    @objc private func buttonTriggered() {
        action?()
    }
}
