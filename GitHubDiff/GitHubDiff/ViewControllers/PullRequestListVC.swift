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
    
    private var refresh: UIRefreshControl {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(handleRefreshe), for: .valueChanged)
        return ref
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MagicalRecord"
        setUpDataSource()
        prViewModel = PullRequestListViewModel()
        prViewModel?.delegate = self
        prTableView.refreshControl = refresh
        prTableView.refreshControl?.beginRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    @objc private func handleRefreshe() {
        prViewModel?.getPRLists()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDiffViewController" {
            if let diffVC = segue.destination as? DiffViewController {
                let prModel = sender as? PullRequestModel
                diffVC.prModel = prModel
            }
        }
    }

}

extension PullRequestListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pullRequest = dataSource?.itemIdentifier(for: indexPath) else { return }
        performSegue(withIdentifier: "toDiffViewController", sender: pullRequest)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PullRequestListVC: PullRequestListProtocol {
    func update(with prList: [PullRequestModel]) {
        createSnapshot(from: prList)
        DispatchQueue.main.async {
            self.prTableView.refreshControl?.endRefreshing()
        }
    }
    
    func showError(with message: String) {
        presentAlert(title: "Error!", message: message, buttonTitle: "Retry.") { [weak self] in
            self?.prViewModel?.getPRLists()
        }
    }
}
