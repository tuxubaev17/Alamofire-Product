//
//  AlamofireNetworkRequest.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import Foundation
import Alamofire


class AlamofireNetworkRequest {
    
    func sendRequst() {
        
//        let parameters: Parameters = [
//                "name": "Black Lotus"
//                ]
        
        guard let url = URL(string: "https://api.magicthegathering.io/v1/cards") else { return }
        AF.request(url, method: .get).validate().responseDecodable(of: Cards.self ) { (responce) in
            switch responce.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                print(data)
            }
        }
    }
}
