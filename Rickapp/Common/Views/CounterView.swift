//
//  CounterView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 15/11/2023.
//

import UIKit
import SnapKit

class CounterView: BaseView {
    private let circleView = UIView()
    private let countLabel = UILabel()
    var counter = Int()
        
    override func setupViews() {
        circleView.layer.cornerRadius = 10
        circleView.backgroundColor = .gray
        
        countLabel.font = .systemFont(ofSize: 14)
        countLabel.textColor = .white
        
        counter = 0
        
        isHidden = true
        
        addSubview(circleView)
        addSubview(countLabel)
    }
    
    override func setupConstraints() {
        circleView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        countLabel.snp.makeConstraints { make in
            make.center.equalTo(circleView)
        }
    }
    
    func changeCounterValue(numberOfFilters: Int) {
        countLabel.text = String(numberOfFilters)
    }
}
