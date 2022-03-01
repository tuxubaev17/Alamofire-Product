//
//  DetailViewModel.swift
//  AlamofireProduct
//
//  Created by Admin on 01.03.2022.
//

import Foundation

class DetailViewModel: DetailViewModelType {
   
    private var card: Card
    
    var descriptionName: String {
        return String(describing: "Name:\(card.name)  --  Mana cost:\(card.manaCost)")
    }
    
    var descriptionType: String {
        return String(describing: "Type:\(card.type) --  Rarity:\(card.rarity)")
    }
    
    var set: String {
        return String(describing: "Set: \(card.set)")
    }
    
    init(card: Card) {
        self.card = card
    }
    
    
}
