// Wojciech Mokwiński
//
//  BaseViewController.swift
//  Rickapp
//
//  Created by Goodylabs on 18/08/2023.
//

import UIKit

class BaseViewController: UIViewController, UIScrollViewDelegate {
    let baseURL = "https://rickandmortyapi.com/api/character"
    
    lazy private var sampleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello"
        label.textColor = UIColor.white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(self.sampleLabel)
        self.setUpConstraints()
    }

    func setUpConstraints() {
        let sampleLabelConstraints = [
            self.sampleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.sampleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(sampleLabelConstraints)
    }

}

