//
//  RickAndMortyPresenter.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 6.03.2022.
//

import Foundation

class RickAndMortyPresenter: RickAndMortyPresenterProtocol {
    var view: RickAndMortyViewDelegate?
    var interactor: RickAndMortyInteractorProtocol?
    init(interactor: RickAndMortyInteractorProtocol, view: RickAndMortyViewDelegate) {
        self.interactor = interactor
        self.view = view
        self.interactor?.delegate = self
    }
    var value: [RickAndMortyPresentations] = []
}

extension RickAndMortyPresenter {
    func load() {
        interactor?.load()
        view?.handleOutPut(.title("RickAndMorty"))
    }
}

extension RickAndMortyPresenter: RickAndMortyInteractorDelegate {
    func handleOutPut(_ output: RickAndMortyInteractorOutPut) {
        switch output {
        case .rickAndMortyList(let array):
//            let data = array.map(RickAndMortyPresentations.init)
            //self.value = data
            view?.handleOutPut(.rickAndMortyList(array))
        case .RickAndMortyError(let string):
            view?.handleOutPut(.rickAndMortyError(string))
        }
    }
}
