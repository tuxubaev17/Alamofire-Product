//
//  TableViewModelType.swift
//  AlamofireProduct
//
//  Created by Admin on 01.03.2022.
//

import UIKit

protocol TableViewModelType {
    func fetchData(completionHandler: @escaping () -> (Void))
    func numberOfRowsInSection() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    func titleForCell(atIndexPath indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    
    func viewModelForSelectedRow() -> DetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
}
