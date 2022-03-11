//
//  RickAndMortyRouter.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 6.03.2022.
//

import Foundation
import UIKit

final class RickAndMortyRouter: RickAndMortyRouterProtocol {
    
    let view: UIViewController
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: RickRouter) {
        switch route {
        case .detail(let rickResult):
            let rickDetail = RickAndMortyDetailBuilder.make(value: rickResult)
            view.show(rickDetail, sender: nil)
        }
    }
}
