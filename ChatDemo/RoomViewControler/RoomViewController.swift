//
//  RoomViewController.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 3/31/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import UIKit
import SocketIO

class RoomViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var cstBottom: NSLayoutConstraint!
    @IBOutlet weak var addChatView: LiveStreamFooterAddComment!
    
    private var listData: [ChatMessageModel] = [] {
        didSet {
            self.table.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        connectSocket()
        loadData()
    }
    
    private func initUI() {
        table.delegate = self
        table.dataSource = self
        table.register( UINib.init(nibName: "ChatTextCell", bundle: nil), forCellReuseIdentifier: "ChatTextCell")
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func connectSocket() {
        
    }
    
    private func loadData() {
        Api().getListOldChat(complete: { [weak self] (listData) in
            self?.listData = listData
        }) { (error) in
            print(error)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            var keyboardHeight = keyboardRectangle.height
            
            let window = UIApplication.shared.windows[0]
            let bottomPadding = window.safeAreaInsets.bottom
            
            keyboardHeight -= bottomPadding
            
            updateUIWhenChangeTypeView(isShowKeyboard: true, keyboardHeight: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        cstBottom.constant = 0
        updateUIWhenChangeTypeView(isShowKeyboard: false, keyboardHeight: 0)
    }
    
    
    private func updateUIWhenChangeTypeView(isShowKeyboard: Bool, keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.cstBottom.constant = keyboardHeight
            self?.view.layoutIfNeeded()
        }
        
        self.addChatView.updateUIWith(isShowKeyboard: isShowKeyboard)
    }
}

extension RoomViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData[section].messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTextCell", for: indexPath) as? ChatTextCell else {
            return UITableViewCell()
        }
        let data = listData[indexPath.section]
        guard let dataMessage = data.messages?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configCell(data: dataMessage, isFrist: indexPath.row == 0, isLast: indexPath.row == (data.messages?.count ?? 0) - 1, isMe: data.isMe ?? true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
