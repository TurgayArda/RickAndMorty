//
//  RickAndMortyPresenter.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 9.03.2022.
//

import Foundation
import UIKit

class RickAndMortyDetailPresenter: RickAndMortyDetailPresenterProtocol {
    var data: RickResult?
    var view: RickAndMortyDetailViewProtocol?
    init(data: RickResult, view: RickAndMortyDetailViewProtocol) {
        self.data = data
        self.view = view
    }
}

extension RickAndMortyDetailPresenter {
    func load() {
        if let dataTwo = data {
        let value = RickAndMortyDetailPresentations(data: dataTwo)
        view?.update(value)
        }
    }
}
