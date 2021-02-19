//
//  PullRequestListViewModel.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/17/21.
//

import Foundation

protocol PullRequestListProtocol: class {
    func update(with prList: [PullRequestModel])
    func showError(with message: String)
}

class PullRequestListViewModel {
    
    weak var delegate: PullRequestListProtocol?
    
    init() {
        getPRLists()
    }
    
    func getPRLists() {
        let networkManager = NetworkManager(url: "https://api.github.com/repos/magicalpanda/MagicalRecord/pulls?state=open")
        networkManager.get(result: [PullRequestModel].self) { [weak self] result in
            switch result {
            case .success(let prList):
                self?.delegate?.update(with: prList)
            case .failure(let error):
                self?.delegate?.showError(with: error.rawValue)
            }
        }
    }
}
