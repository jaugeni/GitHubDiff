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
    
    func set(prModel: PullRequestModel) {
        title?.text = prModel.title
        state?.text = "Pull Requests #\(prModel.number)"
    }

}
