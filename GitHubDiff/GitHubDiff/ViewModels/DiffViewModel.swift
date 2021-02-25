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
    private let network = NetworkManager.share
    
    init(_ urlString: String?) {
        network.url = urlString
        getDiff()
    }
    
    func getDiff(){
        network.get(result: String.self, completed:  { [weak self] result in
            switch result {
            case .success(let diff):
                self?.getModels(from: diff)
            case .failure(let error):
                self?.delegate?.showError(with: error.rawValue)
            }
        })
    }
    
    private func getModels(from stringData: String) {
        
        var diffModels = [DiffModel]()
        
        let diffPerFiles = stringData.components(separatedBy: "diff --git a/")
        for diffPerFile in diffPerFiles {
            if diffPerFile == "" {
                continue
            }
            let linkedlist = getLinkedList(from: diffPerFile)
            let model = getModel(from: linkedlist)
            diffModels.append(contentsOf: model)
        }
        
        self.delegate?.update(with: diffModels)
    }
    
    private func getLinkedList(from string: String) -> LinkedList {
        
        let linkedDiff = LinkedList()
        var counts = (0, 0)
        
        var diffPerLocation = string.components(separatedBy: "\n")
        let diffNode = DiffNode(headerLine: modifydiffGit(with: diffPerLocation[0]), leftLine: nil, leftCount: nil, rightLine: nil, rightCount: nil, lineType: .fileName)
        linkedDiff.append(node: diffNode)
        
        diffPerLocation.remove(at: 0)
    
        for line in diffPerLocation {
            
            if line.contains("+++ ") || line.contains("--- ") {
                continue
            }
            
            if line.contains("@@") {
                counts = handleCount(with: line)
                
                let diffNode = DiffNode(headerLine: line, leftLine: nil, leftCount: nil, rightLine: nil, rightCount: nil, lineType: .position)
                linkedDiff.append(node: diffNode)
                continue
            }
            
            if line.prefix(1) == "+" {
                if let emptyRight = linkedDiff.previusEmptyRight() {
                    emptyRight.rightCount = String(counts.1)
                    emptyRight.rightLine = line
                } else {
                    let diffNode = DiffNode(headerLine: nil, leftLine: nil, leftCount: nil, rightLine: line, rightCount: " \(counts.1) ", lineType: .right)
                    linkedDiff.append(node: diffNode)
                }
                counts.1 += 1
                continue
            }
            
            if line.prefix(1) == "-" {
                if let emptyLeft = linkedDiff.previusEmptyLeft() {
                    emptyLeft.leftCount = String(counts.0)
                    emptyLeft.leftLine = line
                } else {
                    let diffNode = DiffNode(headerLine: nil, leftLine: line, leftCount: " \(counts.0) ", rightLine: nil, rightCount: nil, lineType: .left)
                    linkedDiff.append(node: diffNode)
                }
                counts.0 += 1
                continue
            }
            
            if line.prefix(1) == " " {
                let diffNode = DiffNode(headerLine: nil, leftLine: line, leftCount: " \(counts.0) ", rightLine: line, rightCount: " \(counts.1) ", lineType: .notChanged)
                linkedDiff.append(node: diffNode)
                counts.0 += 1
                counts.1 += 1
                continue
            }
        }
        
        return linkedDiff
    }
    
    private func getModel(from diffPerFile: LinkedList) -> [DiffModel] {
        
        var diffModels = [DiffModel]()
        
        var node = diffPerFile.first
        while node != nil {
            let diffModel = DiffModel(leftLine: node?.leftLine, leftCount: node?.leftCount, rightLine: node?.rightLine, rightCount: node?.rightCount, header: node?.headerLine, lineType: node?.lineType ?? .fileName)
                
            diffModels.append(diffModel)
            node = node?.next
        }
        
        return diffModels
    }
    
    private func modifydiffGit(with line: String) -> String {
        
        let replaceB = line.replacingOccurrences(of: "b/", with: "-> ")
        let compareLines = replaceB.components(separatedBy: " -> ")
        
        if compareLines[0] == compareLines[1] {
            return compareLines[0]
        }
        
        return replaceB
    }
    
    private func handleCount(with line: String) -> (left: Int, right: Int) {
        var counts = (0, 0)
        
        let lineArray = line.components(separatedBy: " ")
        
        let leftNumberString = lineArray[1].components(separatedBy: ",")
        let rightNumberString = lineArray[2].components(separatedBy: ",")
        let removeMinus = leftNumberString[0].replacingOccurrences(of: "-", with: "")
        let removePlus = rightNumberString[0].replacingOccurrences(of: "+", with: "")
        
        if let leftStart = Int(removeMinus) {
            counts.0 =  leftStart
        }
        
        if let rightStart = Int(removePlus) {
            counts.1 = rightStart
        }
        
        return counts
    }
}
