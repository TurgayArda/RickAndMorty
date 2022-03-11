//
//  RickAndMortyInteractor.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 6.03.2022.
//

import Foundation

class RickAndMortyInteractor: RickAndMortyInteractorProtocol {
    var delegate: RickAndMortyInteractorDelegate?
    var service: RickAndMortyServiceProtocol?
    init(service: RickAndMortyServiceProtocol) {
        self.service = service
    }
}

extension RickAndMortyInteractor {
    func load() {
        service?.fetchAllData(onSuccess: { [delegate] data in
            delegate?.handleOutPut(.rickAndMortyList(data))
        }, onError: { [delegate] error in
            delegate?.handleOutPut(.RickAndMortyError(error))
        })
    }
}
