//
//  DiffViewController.swift
//  GitHubDiff
//
//  Created by YAUHENI IVANIUK on 2/18/21.
//

import UIKit

class DiffViewController: UIViewController {

    @IBOutlet weak var diffTableView: UITableView!
    
    enum Section: CaseIterable {
        case main
    }
    
    private var dataSource: UITableViewDiffableDataSource<Section, DiffModel>?
    
    private var diffViewModel: DiffViewModel?
    
    var prModel: PullRequestModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDataSource()
        rotateToLandsScapeDevice()
        updateTitle()
        diffViewModel = DiffViewModel(prModel?.diffUrl)
        diffViewModel?.delegate = self
        navigationController?.hidesBarsOnSwipe = true
        diffTableView.refreshControl = refresh
        diffTableView.refreshControl?.beginRefreshing()
        let topInset: CGFloat = 10
        diffTableView.contentInset.top = topInset
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.rotateToAll()
    }
    
    private func updateTitle() {
        if let prNumber = prModel?.number {
            title = "PR #\(prNumber)"
        } else {
            title = "Pull Requst"
        }
    }
    
    override func handleRefreshe() {
        diffViewModel?.getDiff()
    }
    
    private func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, DiffModel> (tableView: diffTableView) { (tableView, indexPath, diff) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DiffTableViewCell.self), for: indexPath) as? DiffTableViewCell
            cell?.set(with: diff)
            return cell
        }
    }
    
    private func createSnapshot(from diff: [DiffModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DiffModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(diff)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension DiffViewController: DiffViewModelProtocol {
    
    func update(with diff: [DiffModel]) {
        self.createSnapshot(from: diff)
        DispatchQueue.main.async {
            self.diffTableView.refreshControl?.endRefreshing()
        }
    }
    
    func showError(with message: String) {
        presentAlert(title: "Error!", message: message, buttonTitle: "Retry.") { [weak self] in
            self?.diffViewModel?.getDiff()
        }
    }
}
