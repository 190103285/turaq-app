//
//  BaseMapView.swift
//  TuraqApp
//
//  Created by Akyl on 05.03.2023.
//

import UIKit

class BaseMapView: UIView {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initImpl()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initImpl()
    }

    private func initImpl() {

    }
}
