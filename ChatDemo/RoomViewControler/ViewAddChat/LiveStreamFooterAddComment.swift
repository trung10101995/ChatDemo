//
//  GroupAddCommentView.swift
//  KingHub
//
//  Created by Trung on 6/18/20.
//  Copyright © 2020 VivaVietNam. All rights reserved.
//

import Foundation
import UIKit

enum LiveStreamTypeShowCommentView {
    /// Không có text trong ô comment -> đang hiện place
    case none
    /// Khi đang show keyboard sửa comment
    case showKeyboard
    /// Khi hide keyboard khi trong comment textfield đang có text
    case hideKeyboardHasText
    
    func isShowPlaceHolderText() -> Bool {
        switch self {
        case .none:
            return true
        default:
            return false
        }
    }
    
    func maxHeightComemntView() -> CGFloat {
        switch self {
        case .none:
            return 36
        case .showKeyboard:
            return 100
        case .hideKeyboardHasText:
            return 45
        }
    }
    
    func isHideBtn() -> Bool {
        switch self {
        case .showKeyboard:
            return true
        default:
            return false
        }
    }
    
    func minHeightComemntView() -> CGFloat {
        return 36
    }
    
}

//AddCommentView
enum LiveStreamTypeActionInGroupAddComment: Int {
    case game = 1
    case question = 2
    //    case addComment
    case gift = 3
    //    case icon
}

protocol LiveStreamFooterAddCommentProtocol: class {
    func callWhenImgDidTap()
    func callWhenSendCommnetDidTap(text: String)
    func commentViewDidTap()
}

extension Notification.Name {
    static let lstDidLoadArmorial = Notification.Name("lstDidLoadArmorial")
}

class LiveStreamFooterAddComment: XibView {
    
    @IBOutlet var addCommentView: LiveStreamAddCommentView!
    @IBOutlet weak var viewContainerBtnAddImg: UIView!
    
    deinit {
        print("\(Date()): ✅ \(String(describing: self)) deinit!")
    }
    
    var currentTypeShowCommentView = LiveStreamTypeShowCommentView.none {
        didSet {
            upDateUIWhenChangeTypeShow()
        }
    }
    
    var textComment: String = ""
    
    weak var delegate: LiveStreamFooterAddCommentProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addCommentView.layer.zPosition = 1
        self.addCommentView.delegate = self

    }
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    func setupFooterAddComment(delegate: LiveStreamFooterAddCommentProtocol) {
        self.delegate = delegate
    }
    
    func updateUIWith(isShowKeyboard: Bool) {
        getCurrentTypeShowCommentView(isShowKeyboard: isShowKeyboard)
    }
    
    func becomeFirstResponderKeyboard() {
        addCommentView.showKeyboardTfComment()
    }
    
    private func upDateUIWhenChangeTypeShow() {
        
        addCommentView.updateUIWith(typeShowCommentView: currentTypeShowCommentView)
        
        viewContainerBtnAddImg.isHidden = self.currentTypeShowCommentView.isHideBtn()
    }
    
    private func getCurrentTypeShowCommentView(isShowKeyboard: Bool) {
        if isShowKeyboard {
            currentTypeShowCommentView = .showKeyboard
        } else {
            currentTypeShowCommentView = textComment == "" ? .none : .hideKeyboardHasText
        }
    }
    
    @IBAction func didTapActtion(_ sender: UIButton) {
        delegate?.callWhenImgDidTap()
    }
    
}

extension LiveStreamFooterAddComment: LiveStreamAddCommentViewDelegate {
    func textViewDidChange(text: String) {
        self.textComment = text
    }
    
    
    func commentViewDidTap() {
        delegate?.commentViewDidTap()
    }
    
    func callSendCommentDidTap(text: String) {
        self.updateUIWith(isShowKeyboard: true)
        delegate?.callWhenSendCommnetDidTap(text: text)
    }
}
