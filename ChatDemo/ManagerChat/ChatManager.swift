//
//  ChatManager.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 5/4/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import Foundation

struct UserModel {
    var userName: String = ""
    var userAvatar: String = ""
    var userId: String = ""
    var token: String = ""
}

class ChatManager {
    static let shared = ChatManager()
    private init() {}
    
    var isDebugMode = true
    
    var ownerUser = UserModel(userName: "Tên", userAvatar: "https://media.travelmag.vn/files/thuannguyen/2020/04/25/cach-chup-anh-dep-tai-da-lat-1-2306.jpeg", userId: "", token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwNzhmZGQ3N2E5NmFmNWMxNTEyMmMxYSIsInVzZXJuYW1lIjoiMDk2Mjg5MDE1MyIsImlzQWRtaW4iOmZhbHNlLCJwZXJtaXNzaW9ucyI6WyJhbGxVc2VyIl0sImlhdCI6MTYyMDExNjgwMSwiZXhwIjoxNjIwMTIwNDAxfQ.FUelA_5quHZlx9ajZcCzi-nAwmZzihJwoZR0ytJ-0RE")
    var roomId = "607e933db860451cc3ad1fc3"
    
    func configChatManager(OwnerUserModel: UserModel, roomId: String) {
        
    }
}
