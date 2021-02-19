//
//  DiffLabel.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/19/21.
//

import UIKit

class DiffLabel: UILabel {
    
    var topInset: CGFloat = 6.0
    var bottomInset: CGFloat = 6.0
    var leftInset: CGFloat = 4.0
    var rightInset: CGFloat = 4.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
