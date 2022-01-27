//
//  ServiceData.swift
//  Github Respository App
//
//  Created by Inam on 27.01.22.
//

import Foundation
import TRONSwiftyJSON
import SwiftyJSON

struct ServiceData<Data: JSONDecodable>: JSONDecodable {
    
    let object: Data
    
    init(json: JSON) throws {
        if json["error"] != JSON.null {
            throw JSONDecodableError.error
        }
        
        object = try Data(json: json["items"])
        
        URLCache.shared.removeAllCachedResponses()
    }
}

