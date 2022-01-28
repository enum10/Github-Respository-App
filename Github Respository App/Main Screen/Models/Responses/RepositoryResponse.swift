//
//  RepositoryResponse.swift
//  Github Respository App
//
//  Created by Inam on 28.01.22.
//

import Foundation
import TRONSwiftyJSON
import SwiftyJSON

struct RepositoryResponse: JSONDecodable {
    
    let name: String
    let starsCount: Int64
    let watchersCount: Int64
    let forksCount: Int64
    let issuesCount: Int64
    let language: String
    let description: String
    let owner: RepositoryOwner
    
    init(json: JSON) throws {
        name = String(json: json["name"])
        starsCount = Int64(json: json["stargazers_count"])
        watchersCount = Int64(json: json["watchers_count"])
        forksCount = Int64(json: json["forks_count"])
        issuesCount = Int64(json: json["open_issues_count"])
        language = String(json: json["language"])
        description = String(json: json["description"])
        owner = try RepositoryOwner(json: json["owner"])
    }
}
