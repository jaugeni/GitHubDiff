//
//  DiffTableViewCell.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/18/21.
//

import UIKit

class DiffTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: DiffLabel!
    @IBOutlet weak var rightLabel: DiffLabel!

    func set(with diff: DiffModel) {
        switch diff.lineType {
        case .fileName:
            leftLabel.text = diff.leftLine
            rightLabel.isHidden = true
            backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
            leftLabel.backgroundColor = UIColor.clear
        case .position:
            leftLabel.text = diff.leftLine
            rightLabel.isHidden = true
            backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            leftLabel.backgroundColor = UIColor.clear
        case .left:
            leftLabel.text = diff.leftLine
            leftLabel.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
        case .right:
            rightLabel.text = diff.rightLine
            rightLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        case .notChanged:
            rightLabel.text = diff.leftLine
            leftLabel.text = diff.rightLine
        }
    }
    
    override func prepareForReuse() {
        rightLabel.isHidden = false
        rightLabel.backgroundColor = UIColor.white
        leftLabel.backgroundColor = UIColor.white
        backgroundColor = UIColor.white
        leftLabel.text = ""
        rightLabel.text = ""
    }
}
