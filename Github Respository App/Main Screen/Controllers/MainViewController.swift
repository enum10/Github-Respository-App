//
//  MainViewController.swift
//  Github Respository App
//
//  Created by Inam on 27.01.22.
//

import UIKit

class MainViewController: UIViewController {
    
    private var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
