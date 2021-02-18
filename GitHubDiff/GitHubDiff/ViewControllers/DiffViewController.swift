//
//  DiffViewController.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/18/21.
//

import UIKit

class DiffViewController: UIViewController {

    var prModel: PullRequestModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let prNumber = prModel?.number {
            title = "PR #\(prNumber)"
        } else {
            title = "Pull Requst"
        }
    }

}
