//
//  NetworkClient.swift
//  Github Respository App
//
//  Created by Inam on 27.01.22.
//

import Foundation
import TRON
import PromiseKit
import TRONSwiftyJSON

class NetworkClient {
    
    typealias NetworkRequest<Data: JSONDecodable> = APIRequest<ServiceData<Data>, APIError>
    static let shared = NetworkClient()
    
    private let client: TRON
    
    init() {
        client = TRON(baseURL: "https://api.github.com/")
        client.parameterEncoding = URLEncoding.queryString
    }
    
    func getObject<Object: JSONDecodable>(for service: Service) -> Promise<Object> {
        return createRequest(for: service)
            .then { (request: NetworkRequest<Object>) -> Promise<Object> in
                let (promise, resolver) = Promise<Object>.pending()
                request.perform { serviceData in
                    resolver.fulfill(serviceData.object)
                } failure: { apiError in
                    resolver.reject(apiError)
                }

                return promise
            }
    }
    
    private func createRequest<Object: JSONDecodable>(for service: Service) -> Promise<NetworkRequest<Object>> {
        let endPoint = service.endPoint
        
        let request: NetworkRequest<Object> = client.swiftyJSON.request(endPoint)
        request.method = .get
        request.parameters = service.queryParameters
        return Promise<NetworkRequest<Object>>.value(request)
    }
}
