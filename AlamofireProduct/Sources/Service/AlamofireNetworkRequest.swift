//
//  AlamofireNetworkRequest.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import Foundation
import Alamofire


class AlamofireNetworkRequest {
    
    func sendRequst(url: String, completionHandler: @escaping ([Card]) -> ()) {
        
        guard let url = URL(string: url) else { return }
        AF.request(url, method: .get).validate().responseDecodable(of: Cards.self ) { (responce) in
            switch responce.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                DispatchQueue.main.async {
                    completionHandler(data.cards)
                }
                
            }
        }
    }
}
