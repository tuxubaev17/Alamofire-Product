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
    
    private var cards = [Card]()
    private var filteredCardsName = [Card]()
    private var cells = [CellConfgurator]()

    private var isFiltering: Bool = false
    
    private var cardCellBuilder: CardCellBuilderProtocol?
    private var viewModel: TableViewModelType?
    
    var searchController = UISearchController(searchResultsController: nil)

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = Constants.rowHeight
//        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
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
    
    private func completionEvent() {
        viewModel?.fetchData { card in
            self.cards = card
            self.tableView.reloadData()
        }
    }
    
    func filterContentForSearchText(_ searchText: String, completionHandler: @escaping () -> (Void)) {
        filteredCardsName = cards.filter { (cards: Card) -> Bool in
            return cards.name.lowercased().contains(searchText.lowercased())
        }
        isFiltering = searchText.isEmpty == false ? true : false
        DispatchQueue.main.async {
            completionHandler()
        }
    }
}

extension MainController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCardsName.count
        }
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFiltering {
            guard let item: CellConfgurator = cardCellBuilder?.toCardCell(model: filteredCardsName)[indexPath.row] else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
            item.configure(cell: cell)
            return cell
        } else {
            guard let item: CellConfgurator = cardCellBuilder?.toCardCell(model: cards)[indexPath.row] else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
            item.configure(cell: cell)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        
        let detailVC = DetailController()
        var card: Card
        
        if isFiltering {
            card = filteredCardsName[indexPath.row]
            detailVC.viewModel = DetailViewModel(card: card)
        } else {
            card = cards[indexPath.row]
            detailVC.viewModel = DetailViewModel(card: card)
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentForSearchText(text) {
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
