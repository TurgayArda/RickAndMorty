//
//  RickAndMortyService.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 6.03.2022.
//

import Foundation
import Alamofire

protocol RickAndMortyServiceProtocol {
    func fetchAllData(
         onSuccess: @escaping ([RickResult]) -> Void,
         onError: @escaping (String) -> Void
         )
}

class RickAndMortyService: RickAndMortyServiceProtocol {
    func fetchAllData(onSuccess: @escaping ([RickResult]) -> Void, onError: @escaping (String) -> Void) {
        AF.request(Url.url.rawValue, method: .get).responseDecodable(of: RickAndMorty.self) {
            model in
            guard let data = model.value else {
                return onError("data not found")
            }
            let value = data.results
            onSuccess(value)
        }
    }
}
