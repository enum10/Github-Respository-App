//
//  MainViewController.swift
//  Github Respository App
//
//  Created by Inam on 27.01.22.
//

import UIKit
import PureLayout

class MainViewController: UIViewController {
    
    private var searchController: UISearchController?
    private var service: GithubService
    private var topiOSRepositories = [RepositoryResponse]()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        service = GithubServiceImpl(networkClient: NetworkClient.shared)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = service.fetchRepositories(query: "ios",
                                      sort: .byStars,
                                      order: .descending,
                                      page: 1)
            .done { [weak self] repositories in
                self?.topiOSRepositories.removeAll()
                self?.topiOSRepositories.append(contentsOf: repositories)
                self?.tableView.reloadData()
            }
    }
    
    private func setupUI() {
        title = "Repositories"
        view.backgroundColor = .white
        
        setupSearchController()
        setupTableView()
    }
    
    private func setupSearchController() {
        let resultsController = SearchResultsViewController()
        searchController = UISearchController(searchResultsController: resultsController)
        searchController?.searchResultsUpdater = resultsController
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        
        tableView.register(RepositoryCell.self,
                           forCellReuseIdentifier: String(describing: RepositoryCell.self))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topiOSRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryCell.self),
                                                    for: indexPath) as? RepositoryCell {
            let repository = topiOSRepositories[indexPath.row]
            cell.repositoryName = repository.name
            cell.repositoryLanguage = repository.language
            cell.repositoryDescription = repository.description
            cell.repositoryStarCount = repository.starsCount
            cell.repositoryForkCount = repository.forksCount
            cell.repositoryWatcherCount = repository.watchersCount
            cell.ownerName = repository.owner.login
            cell.ownerAvatarURLString = repository.owner.avatarUrl
            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top 10 iOS Repositories"
    }
}

// MARK: - RepositoryCellDelegate

extension MainViewController: RepositoryCellDelegate {
    func repositoryCellRepoSectionClicked(_ cell: RepositoryCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let repository = topiOSRepositories[indexPath.row]
        print(repository.name)
    }
    
    func repositoryCellOwnerSectionClicked(_ cell: RepositoryCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let repository = topiOSRepositories[indexPath.row]
        print(repository.owner.login)
    }
}
