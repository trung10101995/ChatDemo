//
//  ViewController.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 3/31/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func joinDidTap(_ sender: Any) {
        let vc = RoomViewController.init(nibName: "RoomViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

