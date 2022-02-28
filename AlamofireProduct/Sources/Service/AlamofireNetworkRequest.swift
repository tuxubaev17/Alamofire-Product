//
//  AlamofireNetworkRequest.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import Foundation
import Alamofire

struct AlamofireNetworkRequest {
    
    static func sendRequest() {
        guard let url = URL(string: "https://api.magicthegathering.io/v1/cards" ) else { return }
        
        AF.request(url, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let data):
                print(data)
            }
        }
    }
}
