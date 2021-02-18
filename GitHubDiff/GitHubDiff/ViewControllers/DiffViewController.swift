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
        rotateToLandsScapeDevice()
        updateTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.rotateToPotraitScapeDevice()
    }

    func rotateToLandsScapeDevice(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.currentOrientation = .landscape
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
        UIView.setAnimationsEnabled(true)
    }

    func rotateToPotraitScapeDevice(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.currentOrientation = .allButUpsideDown
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UIView.setAnimationsEnabled(true)
    }
    
    private func updateTitle() {
        if let prNumber = prModel?.number {
            title = "PR #\(prNumber)"
        } else {
            title = "Pull Requst"
        }
    }

}
