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
        AF.request(ServiceConstants.Url.url.rawValue, method: .get).responseDecodable(of: RickAndMorty.self) {
            model in
            guard let data = model.value else {
                return onError(ServiceConstants.Error.error.rawValue)
            }
            let value = data.results
            onSuccess(value)
        }
    }
}
