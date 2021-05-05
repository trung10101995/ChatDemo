//
//  ChatMessageModel.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 5/4/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import Foundation

struct ChatMessageModel: Codable {
    var id: String?
    var isMe: Bool?
    var messages: [MessageModel]?
}

struct MessageModel: Codable {
    var message: String?
    var updatedAt: String?
    var type: Int?
}
