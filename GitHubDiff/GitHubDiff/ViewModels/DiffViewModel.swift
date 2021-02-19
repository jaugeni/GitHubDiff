//
//  DiffViewModel.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/18/21.
//

import Foundation

protocol DiffViewModelProtocol: class {
    func update(with diff: String)
    func showError(with message: String)
}

class DiffViewModel {
    
    weak var delegate: DiffViewModelProtocol?

    private var network: NetworkManager?

    init(_ prModel: PullRequestModel?) {
        network = NetworkManager(url: prModel?.diffUrl)
        getDiff()
    }
    
    func getDiff(){
        network?.getData(completed: { [weak self] result in
            switch result {
            case .success(let diff):
                let str = String(decoding: diff, as: UTF8.self)
                self?.delegate?.update(with: str)
            case .failure(let error):
                self?.delegate?.showError(with: error.rawValue)
            }
        })
    }
}
