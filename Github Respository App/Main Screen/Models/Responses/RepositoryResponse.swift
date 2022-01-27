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
    let watchersCount: Int64
    let forksCount: Int64
    let issuesCount: Int64
    let ownerName: String
    let ownerAvatar: String
    
    init(json: JSON) throws {
        name = String(json: json["name"])
        watchersCount = Int64(json: json["watchers_count"])
        forksCount = Int64(json: json["forks_count"])
        issuesCount = Int64(json: json["open_issues_count"])
        ownerName = String(json: json["owner"]["login"])
        ownerAvatar = String(json: json["owner"]["avatar_url"])
    }
}
