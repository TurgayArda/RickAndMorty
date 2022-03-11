//
//  RickAndMortyPresentation+API.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 6.03.2022.
//

import Foundation

extension RickAndMortyPresentations {
    init(data: RickResult) {
        self.init(name: data.name,
                  image: data.image,
                  status: data.status.rawValue,
                  species: data.species.rawValue
                  )
    }
}
