//
//  RickAndMortyDetailPresentations+API.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 8.03.2022.
//

import Foundation

extension RickAndMortyDetailPresentations {
    init(data: RickResult) {
        self.init(name: data.name,
                  image: data.image,
                  status: data.status.rawValue,
                  species: data.species.rawValue,
                  gender: data.gender.rawValue,
                  location: data.location.name,
                  episode: data.episode,
                  origin: data.origin.name
                 )
    }
}
