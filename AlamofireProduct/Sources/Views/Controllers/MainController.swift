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
    
    var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = Constants.rowHeight
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        tableView.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Список пуст"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TableViewModel()
        
        setupHierarchy()
        setupView()
        setupLayout()
        
        searchConfigure()
        completionEvent()
    }
    
    private func searchConfigure() {
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = .white
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск..."
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    private func setupEmptyView() {
        
        if tableView.visibleCells.isEmpty {
            emptyLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
    
    private func completionEvent() {
        viewModel?.fetchData { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Таблица"
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
        detailVC.viewModel = viewModel.viewModelForSelectedRow(forIndexPath: indexPath)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel?.filterContentForSearchText(text) {
            self.tableView.reloadData()
        }
    }
}

extension MainController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
        setupEmptyView()
    }
}
