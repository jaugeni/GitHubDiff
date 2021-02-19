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
    var id = UUID()
    var leftLine: String?
    var leftCount: String?
    var rightLine: String?
    var rightCount: String?
    let header: String?
    let lineType: DiffLineType
}
