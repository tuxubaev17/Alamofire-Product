//
//  CardModel.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import Foundation

struct Cards: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let name: String
    let manaCost: String
    let type: String
    let rarity: String
    let set: String
//    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name, manaCost, type, rarity
        case set = "setName"
//        case imageURL = "imageUrl"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: CodingKeys.name)
        type = try container.decode(String.self, forKey: CodingKeys.type)
        manaCost = try container.decode(String.self, forKey: CodingKeys.manaCost)
        set = try container.decode(String.self, forKey: CodingKeys.set)
        rarity = try container.decode(String.self, forKey: CodingKeys.rarity)
//        imageURL = try container.decode(String.self, forKey: CodingKeys.imageURL)
    }
}
