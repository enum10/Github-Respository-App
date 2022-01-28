//
//  License.swift
//  Github Respository App
//
//  Created by Inam on 28.01.22.
//

import Foundation
import TRONSwiftyJSON
import SwiftyJSON

struct License: JSONDecodable {
    
    let name: String
    
    init(json: JSON) throws {
        name = String(json: json["name"])
    }
}
