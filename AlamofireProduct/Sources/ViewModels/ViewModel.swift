//
//  ViewModel.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import UIKit
import Alamofire

private let url = "https://api.magicthegathering.io/v1/cards"

class ViewModel: TableViewModelType {
    
    private var selectedIndexPath: IndexPath?
    
    var cards = [Card]()
    
    func sendRequst(completionHandler: @escaping () -> (Void)) {
        guard let url = URL(string: url) else { return }
        AF.request(url, method: .get).validate().responseDecodable(of: Cards.self ) { (responce) in
            switch responce.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    self.cards = data.cards
                    completionHandler()
                }
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
    
    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil}
        let card = cards[selectedIndexPath.row]
        
        return DetailViewModel(card: card)

    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    
}
