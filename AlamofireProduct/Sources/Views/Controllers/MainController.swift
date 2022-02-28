//
//  ViewController.swift
//  AlamofireProduct
//
//  Created by Admin on 25.02.2022.
//

import UIKit
import SnapKit

class MainController: UIViewController {
    
    let dataService = AlamofireNetworkRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "Таблица"
        
        dataService.sendRequst()
    }
}


