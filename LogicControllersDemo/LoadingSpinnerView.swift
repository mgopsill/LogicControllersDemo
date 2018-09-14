//
//  LoadingSpinnerViewController.swift
//  LogicControllersDemo
//
//  Created by Mike Gopsill on 14/09/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class LoadingSpinnerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(red: 0.8, green: 0.5, blue: 0.3, alpha: 0.5)
    }
}
