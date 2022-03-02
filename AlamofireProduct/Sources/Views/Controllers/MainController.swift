//
//  ViewController.swift
//  AlamofireProduct
//
//  Created by Admin on 25.02.2022.
//

import UIKit
import SnapKit

private enum Constants {
    static let rowHeight = CGFloat(55)
}

final class MainController: UIViewController {
    
    var viewModel: TableViewModelType?
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = Constants.rowHeight
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        tableView.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()

        tableView.tableHeaderView = searchController.searchBar
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = .white
        
        searchBar.placeholder = "Поиск...."
        searchBar.searchBarStyle = .default
        searchController.dimsBackgroundDuringPresentation = false
        searchBar.autocorrectionType = .no
        searchBar.delegate = self
        definesPresentationContext = true
        
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        
        setupHierarchy()
        setupView()
        setupLayout()
        
        completionEvent()
    
    }
    
    private func completionEvent() {
        viewModel?.fetchData { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
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
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel?.titleForCell(atIndexPath: indexPath, tableView: tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        
        let detailVC = DetailController()
        detailVC.viewModel = viewModel.viewModelForSelectedRow()
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainController: UISearchBarDelegate {
    
}
