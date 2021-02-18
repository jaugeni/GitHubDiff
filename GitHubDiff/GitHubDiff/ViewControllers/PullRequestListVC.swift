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
    
    private var prViewModel: PullRequestListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MagicalRecord"
        setUpDataSource()
        prViewModel = PullRequestListViewModel()
        prViewModel?.delegate = self
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

extension PullRequestListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PullRequestListVC: PullRequestListProtocol {
    func updateData(with prList: [PullRequestModel]) {
        createSnapshot(from: prList)
    }
    
    func showError(with message: String) {
        presentAlert(title: "Error!", message: message, buttonTitle: "Retry.") { [weak self] in
            self?.prViewModel?.getPRLists()
        }
    }
}
