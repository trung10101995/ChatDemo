//
//  ChatMoyaService.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 5/4/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import Moya
//import Result

enum ChatMoyaService {
    case getListOldChat
}

extension ChatMoyaService: TargetType {
    var sampleData: Data {
        return Data()
    }
    
    
    var path: String {
        switch self {
        case .getListOldChat:
            return "chats/messages/\(ChatManager.shared.roomId)"
        }
    }
    
    var baseURL: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = Consts.hostUrl
        components.port = Consts.portUrl
        return components.url!
    }
    
    var method: Method {
        switch self {
        case .getListOldChat:
            return .get
        }
    }

    
    var task: Task {
        switch self {
        case .getListOldChat:
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let headers = Consts.BASE_HEADER
        
        return headers
    }
    
    var parameters: [String: Any] {
        let params: [String: Any] = [:]
        return params
    }
}
