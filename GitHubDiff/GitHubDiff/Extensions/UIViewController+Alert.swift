//
//  UIViewController+Alert.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/17/21.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String, buttonTitle: String, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { action in
                completion()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
