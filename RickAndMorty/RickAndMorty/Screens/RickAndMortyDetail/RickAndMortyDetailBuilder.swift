//
//  RickAndMortyDetailBuilder.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 9.03.2022.
//

import Foundation

class RickAndMortyDetailBuilder {
    static func make(value:RickResult) -> RickAndMortyDetailVC {
        let view = RickAndMortyDetailVC()
        let presenter = RickAndMortyDetailPresenter(data: value , view: view)
        view.presenter = presenter
        return view
    }
}
