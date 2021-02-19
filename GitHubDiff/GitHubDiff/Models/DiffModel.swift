//
//  DiffModel.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/18/21.
//

import Foundation

enum DiffLineType {
    case left
    case right
    case fileName
    case position
    case notChanged
}

struct DiffModel: Hashable {
    let id = UUID()
    let leftLine: String
    let rightLine: String
    let lineType: DiffLineType
}
