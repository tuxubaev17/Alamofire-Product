//
//  ViewModel.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import UIKit
import Alamofire
import CoreAudio



private let url = "https://api.magicthegathering.io/v1/cards"

class ViewModel: TableViewModelType {
    
    private var selectedIndexPath: IndexPath?
    private var network = AlamofireNetworkRequest()
    
    var filteredArray = [String]()
    var cards = [Card]()
    
    func fetchData(completionHandler: @escaping () -> (Void)) {
        network.sendRequst(url: url) { card in
            self.cards = card
            print(card)
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let card = cards[indexPath.row]
        return TableViewCellViewModel(card: card)
    }

    func numberOfRowsInSection() -> Int {
        return cards.count
    }

    func titleForCell(atIndexPath indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell else { return UITableViewCell() }
        
        let cellViewModel = cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func viewModelForSelectedRow(forIndexPath indexPath: IndexPath) -> DetailViewModelType? {
        let card = cards[indexPath.row]
        
        return DetailViewModel(card: card)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
