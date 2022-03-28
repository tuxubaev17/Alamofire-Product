//
//  CellConfigurator.swift
//  AlamofireProduct
//
//  Created by Admin on 18.03.2022.
//

import Foundation
import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}

protocol CellConfgurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
    static var cellClass: AnyClass { get }
}

class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfgurator where CellType.DataType == DataType, CellType: UITableViewCell {
    static var reuseId: String { String(describing: CellType.self) }
    
    let item: DataType
    
    static var cellClass: AnyClass { return CellType.self }
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        (cell as? CellType)?.configure(data: item)
    }
}

