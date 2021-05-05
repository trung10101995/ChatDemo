//
//  Api.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 5/4/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import Foundation
import Moya

class Api {
    func getListOldChat(complete: @escaping ((_ data: [ChatMessageModel]) -> Void), failure: @escaping (_ failure: ChatManagerException) -> Void) {
        let getListOldChat: MultiTarget = MultiTarget(ChatMoyaService.getListOldChat)
        ApiService.callBaseApiReturnArray(apiService: getListOldChat, complete: { (data) in
            if let decoded = try? JSONDecoder().decode([ChatMessageModel].self, from: data) {
                complete(decoded)
                return
            }
            failure(.mapError)
        }) { (error) in
            failure(error)
        }
    }
}
