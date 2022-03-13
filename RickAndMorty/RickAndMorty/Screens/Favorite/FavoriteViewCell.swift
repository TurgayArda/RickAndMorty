//
//  FavoriteViewCell.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 12.03.2022.
//

import UIKit
import AlamofireImage

class FavoriteViewCell: UITableViewCell {

    private var favoriteName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var favoriteImage =  UIImageView()
    
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
        addSubview(favoriteImage)
        addSubview(favoriteName)
        makeImage()
        makeName()
    }
    
    func saveModel(value: String, image: String) {
        favoriteName.text = "Favori name: \(value)"
        favoriteImage.af.setImage(withURL: URL(string: image)!)
    }
}

extension FavoriteViewCell {
    private func  makeImage() {
        favoriteImage.snp.makeConstraints { make in
            make
                .top
                .equalTo(contentView.safeAreaLayoutGuide)
                .offset(20)
            make
                .centerX
                .equalTo(contentView.snp.centerX)
        }
    }
    
    private func makeName() {
        favoriteName.snp.makeConstraints { make in
            make
                .top
                .equalTo(favoriteImage.snp.bottom)
                .offset(10)
            make
                .centerX
                .equalTo(contentView.snp.centerX)
        }
    }
}
