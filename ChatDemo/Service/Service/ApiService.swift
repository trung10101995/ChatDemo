//
//  ApiService.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 5/4/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import Moya
//import Result

enum ChatManagerException {
    case requestError
    case mapError
    
    var textError: String {
        switch self {
        case .requestError:
            return "request error"
        case .mapError:
            return "map error"
        }
    }
}

class ApiService {
    
    static var moyaProvider: MoyaProvider<MultiTarget> {
        if ChatManager.shared.isDebugMode {
            let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
            let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
            return MoyaProvider<MultiTarget>(plugins: [networkLogger])
        } else {
            return MoyaProvider<MultiTarget>()
        }
    }
    
    static func callBaseApiReturnArray(isShowLoading: Bool = true, apiService: MultiTarget, complete: @escaping ((_ data: Data) -> Void), failure: @escaping (_ failure: ChatManagerException) -> Void) {
        
        if isShowLoading {
            WSLoadingView.showWithMask()
        }
        
        moyaProvider.request(apiService) { (result) in
            if isShowLoading {
                WSLoadingView.hide()
            }
            
            switch result {
            case .success(let response):
                do {
                    
                    if ChatManager.shared.isDebugMode {
                        print(try response.mapJSON())
                    }
                    
//                    guard let responseData = try response.mapJSON() as? [[String: Any]] else {
//                        failure(.mapError)
//                        return
//                    }
                    complete(response.data)
                    return
                    
                } catch {
                    failure(.mapError)
                }
            case .failure:
                failure(.requestError)
            }
        }
    }
    
}
