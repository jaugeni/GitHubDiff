//
//  PUllRequestTableViewCell.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/17/21.
//

import UIKit

class PullRequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var state: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(prModel: PullRequestModel) {
        title?.text = prModel.title
        state?.text = "State: \(prModel.state)"
    }

}
