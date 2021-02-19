//
//  DiffViewController.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/18/21.
//

import UIKit

class DiffViewController: UIViewController {

    @IBOutlet weak var diffTextView: UITextView!
    
    var prModel: PullRequestModel?
    
    private var diffViewModel: DiffViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateToLandsScapeDevice()
        updateTitle()
        diffViewModel = DiffViewModel(prModel)
        diffViewModel?.delegate = self
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.rotateToAll()
    }
    
    private func updateTitle() {
        if let prNumber = prModel?.number {
            title = "PR #\(prNumber)"
        } else {
            title = "Pull Requst"
        }
    }
}

extension DiffViewController: DiffViewModelProtocol {
    
    func update(with diff: String) {
        DispatchQueue.main.async {
            self.diffTextView.text = diff
        }
    }
    
    func showError(with message: String) {
        presentAlert(title: "Error!", message: message, buttonTitle: "Retry.") { [weak self] in
            self?.diffViewModel?.getDiff()
        }
    }
}
