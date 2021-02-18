//
//  PullRequestModel.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/17/21.
//

import Foundation

struct PullRequestModel: Codable, Hashable {
    let title: String
    let diffUrl: String
    let state: String
    let number: Int
}
