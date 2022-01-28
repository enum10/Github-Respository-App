//
//  RepositoryOwner.swift
//  Github Respository App
//
//  Created by Inam on 28.01.22.
//

import Foundation
import TRONSwiftyJSON
import SwiftyJSON

struct RepositoryOwner: JSONDecodable {
    
    let login: String
    let avatarUrl: String
    
    init(json: JSON) throws {
        login = String(json: json["login"])
        avatarUrl = String(json: json["avatar_url"])
    }
}
