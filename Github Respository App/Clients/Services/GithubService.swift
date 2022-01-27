//
//  GithubService.swift
//  Github Respository App
//
//  Created by Inam on 28.01.22.
//

import Foundation
import PromiseKit

protocol GithubService {
    func fetchRepositories(query: String,
                           sort: SearchSort?,
                           order: SearchOrder?,
                           page: Int) -> Promise<[RepositoryResponse]>
}

class GithubServiceImpl: GithubService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchRepositories(query: String,
                           sort: SearchSort?,
                           order: SearchOrder?,
                           page: Int) -> Promise<[RepositoryResponse]> {
        let service: Service = .repository(query: query,
                                           sort: sort,
                                           order: order,
                                           page: page)
        return networkClient.getObject(for: service)
    }
}
