//
//  SkeletonView.swift
//  TuraqApp
//
//  Created by Akyl Temirgaliyev on 09.04.2023.
//

import UIKit
import SkeletonView

extension UIView {
    
    func makeSkeletonable(_ view: UIView) {
        view.isSkeletonable = true
        view.skeletonCornerRadius = 5
        
        if let label = view as? UILabel {
            label.linesCornerRadius = 5
            label.skeletonTextLineHeight = .relativeToFont
        }
    }
    
    func makeSkeletonable(_ subviews: [UIView]) {
        subviews.forEach { subview in
            makeSkeletonable(subview)
        }
    }
    
    func showSkeletonAnimation() {
//        SkeletonAppearance.default.gradient = SkeletonGradient(colors: UIColor.background)
//        showSkeletonAnimation()
    }
    
    func hideSkeletonAnimation(reloadDataAfter: Bool = true) {
        hideSkeleton(reloadDataAfter: reloadDataAfter, transition: .crossDissolve(0.5))
    }
    
    func setLabelForSkeleton(label: UILabel, lettersCount: Int) {
        label.linesCornerRadius = 5
        label.skeletonTextLineHeight = .relativeToFont
        
        label.text = String(repeating: "-", count: lettersCount)
    }
}
