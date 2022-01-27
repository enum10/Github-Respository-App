//
//  SearchResultsViewController.swift
//  Github Respository App
//
//  Created by Inam on 27.01.22.
//

import UIKit

class SearchResultsViewController: UITableViewController {
    
    private var searchedRepos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        // TODO: Customize results table
    }
}

// MARK: - UITableView Delegate and DataSource

extension SearchResultsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return searchedRepos.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Return correct cell
        return UITableViewCell()
    }
}

// MARK: - UISearchResultsUpdating

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            // TODO: Return custom error
            return
        }
        
        // TODO: Update table view with search repos
        print(text)
    }
}
