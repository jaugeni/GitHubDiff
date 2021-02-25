//
//  UIViewController+Refresh.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/25/21.
//

import UIKit

extension UIViewController {
    var refresh: UIRefreshControl {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(handleRefreshe), for: .valueChanged)
        return ref
    }
    
    @objc func handleRefreshe() {
        print("Should be overrided.")
    }
}
