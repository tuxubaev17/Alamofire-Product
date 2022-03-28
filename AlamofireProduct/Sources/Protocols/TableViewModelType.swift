//
//  TableViewModelType.swift
//  AlamofireProduct
//
//  Created by Admin on 01.03.2022.
//

import UIKit

protocol TableViewModelType {
    func fetchData(completionHandler: @escaping ([Card]) -> (Void))
    func selectRow(atIndexPath indexPath: IndexPath)
}
