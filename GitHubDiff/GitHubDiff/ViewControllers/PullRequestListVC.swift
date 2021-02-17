//
//  PullRequestListVC.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/17/21.
//

import UIKit

class PullRequestListVC: UIViewController {
    
    @IBOutlet weak var prTableView: UITableView!
    
    enum Section: CaseIterable {
        case open
    }
    
    private var dataSource: UITableViewDiffableDataSource<Section, PullRequestModel>?
    
    private let prViewModel = PullRequestListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MagicalRecord"
        setUpDataSource()
        createSnapshot(from: prViewModel.prList)
    }
    
    private func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, PullRequestModel> (tableView: prTableView) { (tableView, indexPath, pr) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PullRequestTableViewCell.self), for: indexPath) as? PullRequestTableViewCell
            cell?.set(prModel: pr)
            return cell
        }
    }
    
    private func createSnapshot(from prs: [PullRequestModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PullRequestModel>()
        snapshot.appendSections([.open])
        snapshot.appendItems(prs)
        dataSource?.apply(snapshot,animatingDifferences: true)
    }

}
