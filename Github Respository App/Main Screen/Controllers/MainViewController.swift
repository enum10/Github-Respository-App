//
//  MainViewController.swift
//  Github Respository App
//
//  Created by Inam on 27.01.22.
//

import UIKit

class MainViewController: UIViewController {
    
    private var searchController: UISearchController?
    private var service: GithubService
    
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
        
        _ = service.fetchRepositories(query: "swift",
                                      sort: nil,
                                      order: nil,
                                      page: 1)
            .done { response in
                print(response)
            }
    }
    
    private func setupUI() {
        title = "Repositories"
        view.backgroundColor = .white
        
        setupSearchController()
    }
    
    private func setupSearchController() {
        let resultsController = SearchResultsViewController()
        searchController = UISearchController(searchResultsController: resultsController)
        searchController?.searchResultsUpdater = resultsController
        navigationItem.searchController = searchController
    }
}
