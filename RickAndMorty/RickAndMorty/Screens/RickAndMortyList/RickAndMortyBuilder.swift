//
//  RickAndMortyBuilder.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 6.03.2022.
//

import Foundation

final class RickAndMortyBuilder {
    static func make() -> RickAndMortyVC {
        let view = RickAndMortyVC()
        let router = RickAndMortyRouter(view: view)
        let interactor = RickAndMortyInteractor(service: RickAndMortyService())
        let presenter = RickAndMortyPresenter(interactor: interactor, view: view)
        let cell = RickCollectionViewCell()
        view.cell = cell
        view.presenter = presenter
        view.router = router
        return view
    }
}
