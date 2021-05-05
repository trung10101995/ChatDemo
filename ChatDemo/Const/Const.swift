//
//  Const.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 5/4/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import Foundation

struct Consts {
    
    static var hostUrl: String {
        return "172.105.122.63"
    }
    
    static let portUrl: Int = 3000
    
    static let BASE_HEADER: [String: String] = [
        "Authorization": "Bearer \(ChatManager.shared.ownerUser.token)"
    ]
}
