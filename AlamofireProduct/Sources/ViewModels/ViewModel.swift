//
//  ViewModel.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import Foundation
import UIKit
// Этот класс пока не работает,  но это пример 
private let url = "https://api.magicthegathering.io/v1/cards"

class ViewModel {
    
    let dataService = AlamofireNetworkRequest()
    private var cards = [Card]()
    
    func fetchData(completionHandler: @escaping () -> (Void)) {
        dataService.sendRequst(url: url) { card in
            self.cards = card
            completionHandler()
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return cards.count
    }
    
    func titleForCell(atIndexPath indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell
    
        cell?.configureCell(model: cards[indexPath.row])
        
        return cell ?? UITableViewCell()
        

    }
    
}
