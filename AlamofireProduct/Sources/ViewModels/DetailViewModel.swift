//
//  DetailViewModel.swift
//  AlamofireProduct
//
//  Created by Admin on 01.03.2022.
//

import Foundation
import UIKit

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
    
    var text: String {
        guard let text = card.text else { return "" }
        return text
    }
    
    var image: String {
        return card.imageURL ?? ""
    }
    
    init(card: Card) {
        self.card = card
    }
    
    
}
