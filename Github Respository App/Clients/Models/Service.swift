//
//  Service.swift
//  Github Respository App
//
//  Created by Inam on 27.01.22.
//

import Foundation

enum Service {
    case repository(query: String,
                    sort: SearchSort?,
                    order: SearchOrder?,
                    page: Int)
    
    var endPoint: String {
        switch self {
        case .repository:
            return "search/repositories"
        }
    }
    
    var queryParameters: [String: Any] {
        switch self {
        case .repository(let query,
                         let sort,
                         let order,
                         let page):
            return GithubQueryComposer.compose(query: query,
                                               sort: sort,
                                               order: order,
                                               page: page)
        }
    }
}
