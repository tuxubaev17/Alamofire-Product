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
    private var cards = [Card]()
    
    private let url = "https://api.magicthegathering.io/v1/cards"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = 55
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        tableView.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupView()
        setupLayout()
        
        
        dataService.sendRequst(url: url) { card in
            self.cards = card
            self.tableView.reloadData()
        }
    
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        title = "Таблица"
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
}

extension MainController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        let model = cards[indexPath.row]
        
        cell.configureCell(model: model)
        return cell
    }
    
    
}

