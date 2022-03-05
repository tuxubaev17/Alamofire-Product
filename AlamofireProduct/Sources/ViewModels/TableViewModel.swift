//
//  ViewModel.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import UIKit
import Alamofire
import CoreAudio
import SwiftUI

private let url = "https://api.magicthegathering.io/v1/cards"

class TableViewModel: TableViewModelType {
    
    private var networkManager = AlamofireNetworkRequest()
    
    private var selectedIndexPath: IndexPath?

    private var cards = [Card]()
    private var filteredCardsName = [Card]()
    
    private var isFiltering: Bool = false
    
    func fetchData(completionHandler: @escaping () -> (Void)) {
        networkManager.sendRequst(url: url) { card in
            self.cards = card
            print(self.cards)
            DispatchQueue.main.async {
                completionHandler()
            }
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
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let card: Card
        
        if isFiltering {
            card = filteredCardsName[indexPath.row]
            return TableViewCellViewModel(card: card)
        } else {
            card = cards[indexPath.row]
            return TableViewCellViewModel(card: card)
        }
    
    }

    func numberOfRowsInSection() -> Int {
        if isFiltering {
            return filteredCardsName.count
        }
        return cards.count
    }

    func titleForCell(atIndexPath indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell else { return UITableViewCell() }
        
        let cellViewModel = cellViewModel(forIndexPath: indexPath)
        cell.configure = cellViewModel
        
        return cell
    }
    
    func viewModelForSelectedRow(forIndexPath indexPath: IndexPath) -> DetailViewModelType? {
        var card: Card
        
        if isFiltering {
            card = filteredCardsName[indexPath.row]
            return DetailViewModel(card: card)
        } else {
            card = cards[indexPath.row]
            return DetailViewModel(card: card)
        }
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
}
