//
//  RickAndMortyDetailContracts.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 9.03.2022.
//

import Foundation

//MARK: - Presenter
protocol RickAndMortyDetailPresenterProtocol {
    func load()
}

//MARK: - View
protocol RickAndMortyDetailViewProtocol {
    func update(_ presentation: RickAndMortyDetailPresentations)
}

