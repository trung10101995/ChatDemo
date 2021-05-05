//
//  BaseSocketIO.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 3/31/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import Foundation
import SocketIO

struct KeyNotification {
    static let kSocketReconnect = "kSocketReconnect"
}

class BaseSocketIO {
    
    static let SOCKET_URL: String = "http://172.105.122.63:3000"
    
    enum typeEventSocket: String {
        case sendMessage = "msgToId"
        case sendMessageStatus = "msgToIdStatus"
        case receiveMessage = "msgFromId"
        case connected = "connected"
    }
    
    static var sharedInstance = BaseSocketIO()
    private init() {}
    
    var manager = SocketManager(socketURL: URL(string: BaseSocketIO.SOCKET_URL)!, config: [.reconnects(true),.log(true), .forceNew(true),.forceWebsockets(true)])
    var socket : SocketIOClient?
    
    public func configSocketIO() {
        
//        socket = manager.socket(forNamespace: "/user")
        
        socket?.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            self.authenSocket()
            
        }
        
        socket?.on(clientEvent: .disconnect) {data, ack in
            print("socket disconnect")
        }
        
        
        socket?.on(clientEvent: .error ) {data, ack in
            print("socket error")
        }
        
        socket?.on("authentication") {data, ack in
            self.authenReceiveData(data:data)
        }
        
        socket?.on("stream") {data, ack in
//            self.receiveDataStream(data:data)
        }
        
        socket?.connect()
    }
    
    private func authenReceiveData(data:[Any]){
        if let first = data.first as? String {
            if let json = Utils.convertToDictionary(text: first) {
                if let code = json["code"] as? Int, code == 200 {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: KeyNotification.kSocketReconnect), object: nil, userInfo: nil)
                }
            }
        }
    }
    
    private func authenSocket(){
        let sessionID = ""
        let string = "{\"sessionID\":\"\(sessionID)\"}"
        socket?.emit("authentication", with: [string])
    }
    
//    private func receiveDataStream(data:[Any]){
//        print(data)
//        if let first = data.first as? String {
//            if let json = Utils.convertToDictionary(text: first) {
//                if let status = json["status"] as? Int, status == 1,
//                    let code = json["code"] as? Int,
//                    let result = json["result"] as? [String:Any] {
//
//                }
//            }
//
//        }
//    }
    
//    func joinLivestreamPost(postId:String){
//        let params = ["code":506,
//                      "post_id":postId,
//                      "parent_comment_id":"",
//                      "media_id":""] as [String:Any]
//        print(params)
//        if let data = Utils.convertString(byObject: params) {
//            self.socket?.emit("stream", with: [data], completion: {
//                print("HEHE")
//            })
//            //            self.socket?.emitWithAck("stream", with: [data]).timingOut(after: 1) {data in
//            //
//            //            }
//        }
//    }
//
}

class Utils {
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func convertString(byObject object:Any) -> String?{
        guard let json = try? JSONSerialization.data(withJSONObject: object, options: []) else { return nil }
        if let string =  String(data: json, encoding: String.Encoding.utf8) {
            return string
        }
        else{
            return nil
        }
    }
}
