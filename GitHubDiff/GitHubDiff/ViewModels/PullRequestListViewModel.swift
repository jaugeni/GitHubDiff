//
//  PullRequestListViewModel.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/17/21.
//

import Foundation

protocol PullRequestListProtocol: class {
    func updateData(with prList: [PullRequestModel])
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
                self?.delegate?.updateData(with: prList)
            case .failure(let error):
                self?.delegate?.showError(with: error.rawValue)
            }
        }
    }
    
    private func getPrList() -> [PullRequestModel] {
        let item1 = PullRequestModel(title: "Use only numbers from git tags when creating CFBundleShortVersionString", diffUrl: "www.github.com", state: "Open")
        let item2 = PullRequestModel(title: "After solving iOS13, set NSPersistentCloudKitContainer", diffUrl: "www.github.com", state: "Open")
        let item3 = PullRequestModel(title: "Add support for watch os, disable iCloud for watch.", diffUrl: "www.github.com", state: "Open")
        return [item1, item2, item3]
    }
}
