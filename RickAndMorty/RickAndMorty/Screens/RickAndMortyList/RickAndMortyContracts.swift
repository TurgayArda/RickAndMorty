//
//  RickAndMortyContracts.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 6.03.2022.
//

import Foundation

//MARK: - Interactor
protocol RickAndMortyInteractorProtocol {
    var delegate: RickAndMortyInteractorDelegate? { get set }
    func load()
}

enum RickAndMortyInteractorOutPut {
    case rickAndMortyList([RickResult])
    case RickAndMortyError(String)
}

protocol RickAndMortyInteractorDelegate {
    func handleOutPut(_ output: RickAndMortyInteractorOutPut)
}

//MARK: - Presenter
protocol RickAndMortyPresenterProtocol {
    func load()
}

enum RickAndMortyPresenterOutPut {
    case rickAndMortyList([RickResult])
    case rickAndMortyError(String)
    case title(String)
}

//MARK: - View
protocol RickAndMortyViewDelegate {
    func handleOutPut(_ output: RickAndMortyPresenterOutPut)
}

//MARK - Provider
protocol RickAndMortyProviderProtocol {
    var delegate: RickAndMortyProviderDelegate? { get set }
    func load(value: [RickResult])
    func search(issearch: Bool)
    func layout(islayout: Bool)
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String)
    func isFavorite(name: [String])
}


protocol RickAndMortyProviderDelegate {
    func selected(at select: RickResult)
}

//MARK: - Router
enum RickRouter {
    case detail(RickResult)
}

protocol RickAndMortyRouterProtocol {
    func navigate(to route: RickRouter)
}
