//
//  SearchInputView.swift
//  ITunes Search
//
//  Created by Jeffrey Tabios on 6/30/23.
//

import Foundation
import UIKit

final class SearchInputView: UIView {
    lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Green")
        return view
    }()

    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Type the song name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.cornerRadius = 15.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.brown.cgColor
        textField.layer.masksToBounds = true
        textField.backgroundColor = .black

        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always

        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.rightViewMode = .always
        return textField
    }()

    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configuration
private extension SearchInputView {

    func configure() {
        addSubview(background)
        addSubview(searchTextField)

        background.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),

            searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0),
        ])
    }
}
