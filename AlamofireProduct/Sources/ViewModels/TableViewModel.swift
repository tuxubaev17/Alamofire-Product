//
//  ViewModel.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import UIKit

private let url = "https://api.magicthegathering.io/v1/cards"

class TableViewModel: TableViewModelType {
    
    private var networkManager = AlamofireNetworkRequest()
    
    private var selectedIndexPath: IndexPath?
    
    private var isFiltering: Bool = false
        
    func fetchData(completionHandler: @escaping ([Card]) -> (Void)) {
        networkManager.sendRequst(url: url) { card in
            DispatchQueue.main.async {
                completionHandler(card)
            }
        }
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
}
