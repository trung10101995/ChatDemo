//
//  AddCommentView.swift
//  KingHub
//
//  Created by Trung on 6/18/20.
//  Copyright © 2020 VivaVietNam. All rights reserved.
//

import Foundation
import UIKit

protocol LiveStreamAddCommentViewDelegate: class {
    func callSendCommentDidTap(text: String)
    func textViewDidChange(text: String)
}

class LiveStreamAddCommentView: XibView {
    
    
    weak var delegate: LiveStreamAddCommentViewDelegate?
    
    var textString: String = "" {
        didSet {
            checkUI()
            delegate?.textViewDidChange(text: textString)
        }
    }
    
    var currentTypeShowCommentView = LiveStreamTypeShowCommentView.none {
        didSet {
            showUIWhenChangeTypeShowCommentView()
        }
    }
    
    @IBOutlet weak var textViewComment: UITextView!
    @IBOutlet var viewContainerBtnSend: UIView!
    @IBOutlet var tfCommentHeight: NSLayoutConstraint!
    
    @IBOutlet var lblPlaceHolder: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textString = ""
        lblPlaceHolder.text = "Aa"
        textViewComment.delegate = self
    }
    
    override func layoutSubviews() {
        showUIWhenChangeTypeShowCommentView()
        setupUI()
    }
    
    // MARK: internal func
    func updateUIWith(typeShowCommentView: LiveStreamTypeShowCommentView) {
        currentTypeShowCommentView = typeShowCommentView
    }
    
    func showKeyboardTfComment() {
        self.textViewComment.becomeFirstResponder()
    }
    
    
    // MARK: private func
    private func setupUI() {
        
    }
    
    private func showUIWhenChangeTypeShowCommentView() {
        calculateHeightTfComment(text: textString)
    }
    
    private func checkUI() {
        viewContainerBtnSend.isHidden = textViewComment.text == ""
        lblPlaceHolder.isHidden = textViewComment.text != ""
    }
    
    // MARK: Action
    
    @IBAction func didTapSend(_ sender: Any) {
        let text: String = textViewComment.text.trimmingCharacters(in: .whitespacesAndNewlines)
        textViewComment.text = ""
        textString = ""
        delegate?.callSendCommentDidTap(text: text)
        
        
    }
    
    private func calculateHeightTfComment(text: String) {
        
        let sizeToFitIn: CGSize = CGSize(width: self.textViewComment.bounds.size.width, height: CGFloat(MAXFLOAT))
        let newSize = self.textViewComment.sizeThatFits(sizeToFitIn)
        
        self.tfCommentHeight.constant = min(currentTypeShowCommentView.maxHeightComemntView(), max(currentTypeShowCommentView.minHeightComemntView(), newSize.height))
        self.viewXIB.layoutIfNeeded()
    }
}

extension LiveStreamAddCommentView : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView)  {
        self.lblPlaceHolder.isHidden = self.textViewComment.text.count > 0
        textString = (textView.text ?? "").trimmingCharacters(in: .whitespaces)
        calculateHeightTfComment(text: textString)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let newPosition = textViewComment.endOfDocument
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.textViewComment.selectedTextRange = strongSelf.textViewComment.textRange(from: newPosition, to: newPosition)
        }
    }
}
