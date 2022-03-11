//
//  FavoriteViewCell.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 12.03.2022.
//

import UIKit

class FavoriteViewCell: UITableViewCell {

    private var favoriteName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    enum Identifier: String {
        case path = "Cell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }
    
    private func configure() {
        addSubview(favoriteName)
        makeName()
    }
    
    func saveModel(value: String) {
        favoriteName.text = "Favori name: \(value)"
    }
}

extension FavoriteViewCell {
    private func makeName() {
        favoriteName.snp.makeConstraints { make in
            make
                .top
                .equalTo(contentView)
                .offset(10)
            make
                .left
                .equalTo(contentView)
                .offset(20)
//            make
//                .centerX
//                .equalTo(contentView.snp.centerX)
        }
    }
}
