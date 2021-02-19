//
//  DiffTableViewCell.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/18/21.
//

import UIKit

class DiffTableViewCell: UITableViewCell {
    
    enum Constant {
        static let darkGray = UIColor.systemGray.withAlphaComponent(0.5)
        static let blue = UIColor.systemBlue.withAlphaComponent(0.1)
        static let darkRed = UIColor.systemRed.withAlphaComponent(0.3)
        static let lightRed = UIColor.systemRed.withAlphaComponent(0.1)
        static let darkGreen = UIColor.systemGreen.withAlphaComponent(0.3)
        static let lightGreen =  UIColor.systemGreen.withAlphaComponent(0.1)
        static let white = UIColor.systemGray.withAlphaComponent(0.1)
    }

    @IBOutlet weak var leftLabel: DiffLabel!
    @IBOutlet weak var leftCountLabel: DiffLabel!
    @IBOutlet weak var rightLabel: DiffLabel!
    @IBOutlet weak var rightCountLabel: DiffLabel!
    @IBOutlet weak var rightStackView: UIStackView!
    
    func set(with diff: DiffModel) {
        
        switch diff.lineType {
        case .fileName:
            leftLabel.text = diff.header
            label(isHidden: true)
            backgroundColor = Constant.darkGray
            leftLabel.backgroundColor = .clear
        case .position:
            leftLabel.text = diff.header
            label(isHidden: true)
            backgroundColor = Constant.blue
            leftLabel.backgroundColor = .clear
        case .left, .right:
            handleLeftRight(with: diff)
        case .notChanged:
            rightLabel.text = diff.rightLine
            rightCountLabel.text = diff.rightCount
            leftLabel.text = diff.leftLine
            leftCountLabel.text = diff.leftCount
        }
    }
    
    private func handleLeftRight(with diff: DiffModel) {
        if let left = diff.leftLine, let leftCount = diff.leftCount {
            leftLabel.text = left
            leftLabel.backgroundColor = Constant.lightRed
            leftCountLabel.text = leftCount
            leftCountLabel.backgroundColor = Constant.darkRed
        }
        if let right = diff.rightLine, let rightCount = diff.rightCount {
            rightLabel.text = right
            rightLabel.backgroundColor = Constant.lightGreen
            rightCountLabel.text = rightCount
            rightCountLabel.backgroundColor = Constant.darkGreen
        }
        
        if diff.leftLine == nil {
            leftLabel.backgroundColor = .clear
            leftCountLabel.backgroundColor = .clear
            backgroundColor = Constant.white
        }
        
        if diff.rightLine == nil {
            rightLabel.backgroundColor = .clear
            rightCountLabel.backgroundColor = .clear
            backgroundColor = Constant.white
        }
    }
    
    override func prepareForReuse() {
        
        label(isHidden: false)
        rightLabel.backgroundColor = .white
        leftLabel.backgroundColor = .white
        rightCountLabel.backgroundColor = .white
        leftCountLabel.backgroundColor = .white
        backgroundColor = UIColor.white
        leftLabel.text = ""
        leftCountLabel.text = ""
        leftLabel.text = ""
        rightCountLabel.text = ""
    }
    
    private func label(isHidden: Bool) {
        leftCountLabel.isHidden = isHidden
        rightStackView.isHidden = isHidden
    }
}
