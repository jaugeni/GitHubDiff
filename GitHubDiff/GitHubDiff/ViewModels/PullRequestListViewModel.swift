//
//  PullRequestListViewModel.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/17/21.
//

import Foundation

class PullRequestListViewModel {
    
    var prList = [PullRequestModel]()
    
    init() {
        prList = getPrList()
    }
    
    func getPrList() -> [PullRequestModel] {
        let item1 = PullRequestModel(title: "Use only numbers from git tags when creating CFBundleShortVersionString", diffUrl: "www.github.com", state: "Open")
        let item2 = PullRequestModel(title: "After solving iOS13, set NSPersistentCloudKitContainer", diffUrl: "www.github.com", state: "Open")
        let item3 = PullRequestModel(title: "Add support for watch os, disable iCloud for watch.", diffUrl: "www.github.com", state: "Open")
        return [item1, item2, item3]
    }
}
