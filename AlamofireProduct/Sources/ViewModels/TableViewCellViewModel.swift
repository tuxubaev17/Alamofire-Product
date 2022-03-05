//
//  TableViewCellViewModel.swift
//  AlamofireProduct
//
//  Created by Admin on 01.03.2022.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {
   
    private var card: Card
    
    var name: String {
        return card.name
    }
     
    var rarity: String {
        return card.rarity
    }
    
    init(card: Card) {
        self.card = card
    }
}
