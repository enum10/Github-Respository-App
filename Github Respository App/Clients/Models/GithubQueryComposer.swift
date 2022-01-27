//
//  GithubQueryComposer.swift
//  Github Respository App
//
//  Created by Inam on 27.01.22.
//

import Foundation

class GithubQueryComposer {
    
    private static let queryKey = "q"
    private static let sortKey = "sort"
    private static let orderKey = "order"
    private static let perPageKey = "per_page"
    private static let pageKey = "page"
    
    static func compose(query: String,
                        sort: SearchSort?,
                        order: SearchOrder?,
                        page: Int) -> [String: Any] {
        var result: [String: Any] = [
            queryKey: query,
            perPageKey: 1,
            pageKey: page
        ]
        
        if let sort = sort {
            result[sortKey] = sort.rawValue
        }
        
        if let order = order {
            result[orderKey] = order.rawValue
        }
        
        return result
    }
}
