//
//  CardCellBuilder.swift
//  AlamofireProduct
//
//  Created by Admin on 24.03.2022.
//

import UIKit

protocol CardCellBuilderProtocol {
    func toCardCell(model: [Card]) -> [CellConfgurator]
}

class CardCellBuilder: CardCellBuilderProtocol {
    func toCardCell(model: [Card]) -> [CellConfgurator] {
        var cellConfigurators = [CellConfgurator]()
        for cardModel in model {
            let titleLabel = NSAttributedString(string: cardModel.name)
            let rarityLabel = NSAttributedString(string: cardModel.rarity)
            let cellModel = CardCellModel(titleLabel: titleLabel, rarityLabel: rarityLabel)
            let configurator = CardCellConfig(item: cellModel)
            cellConfigurators.append(configurator)
        }
        return cellConfigurators
    }
}
