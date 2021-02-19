//
//  DiffViewModel.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/18/21.
//

import Foundation

protocol DiffViewModelProtocol: class {
    func update(with diff: [DiffModel])
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
                guard let self = self else { return }
                let str = String(decoding: diff, as: UTF8.self)
                self.delegate?.update(with: self.getModel(from: str))
            case .failure(let error):
                self?.delegate?.showError(with: error.rawValue)
            }
        })
    }
    
    private func getModel(from stringData: String) -> [DiffModel] {
        var diffModels = [DiffModel]()

        let lines = stringData.components(separatedBy: "\n")
        for line in lines {
            
            if line.contains("+++ ") || line.contains("--- ") {
                continue
            }
            
            if line.contains("@@") {
                let diffModel = DiffModel(leftLine: line, rightLine: "", lineType: .position)
                diffModels.append(diffModel)
            }
            
            if line.contains("diff --git") {
                let diffModel = DiffModel(leftLine: line, rightLine: "", lineType: .fileName)
                diffModels.append(diffModel)
            }
            
            if line.prefix(1) == "+" {
                let diffModel = DiffModel(leftLine: "", rightLine: line, lineType: .right)
                diffModels.append(diffModel)
            }
            
            if line.prefix(1) == "-" {
                let diffModel = DiffModel(leftLine: line, rightLine: "", lineType: .left)
                diffModels.append(diffModel)
            }
            
            if line.prefix(1) == " " {
                let diffModel = DiffModel(leftLine: line, rightLine: line, lineType: .notChanged)
                diffModels.append(diffModel)
            }
        }
        
        return diffModels
    }
}
