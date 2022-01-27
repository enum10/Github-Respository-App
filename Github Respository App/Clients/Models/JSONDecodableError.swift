//
//  JSONDecodableError.swift
//  Github Respository App
//
//  Created by Inam on 27.01.22.
//

import Foundation
import TRONSwiftyJSON
import SwiftyJSON

enum JSONDecodableError: Error {
    case undecodable
    case error
}

extension Array: JSONDecodable where Element: JSONDecodable {
    public init(json: JSON) throws {
        self = Array(json.arrayValue.compactMap { try? Element(json: $0) })
    }
}
