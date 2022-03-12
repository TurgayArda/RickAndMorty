//
//  RickCollectionViewCell.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 6.03.2022.
//

import UIKit
import SnapKit
import AlamofireImage
import CoreData

class RickCollectionViewCell: UICollectionViewCell {
    
    private lazy var rickName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        addSubview(label)
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let playButton  = UIButton(type: .system)
        let paperPlane = UIImage(systemName: "star.fill")
        playButton.alpha = 0
        playButton.setImage(paperPlane, for: .normal)
        addSubview(playButton)
        return playButton
    }()
    
    private lazy var status: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        addSubview(label)
        return label
    }()
    
    private lazy var species: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        addSubview(label)
        return label
    }()
    
    private lazy var image: UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .white
        contentView.addSubview(image)
        return image
    }()
    
    enum Identifier: String {
        case path = "Cell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }
    
    private func configure() {
        makeImage()
        makeName()
        makeStatus()
        makeSpecies()
        makeFavorite()
    }
    
    override func prepareForReuse() {
        isFavorite(isBool: false)
    }

    func saveModel(value: RickResult) {
        rickName.text = "Name: \(value.name)"
       image.af.setImage(withURL: URL(string: value.image)!)
       status.text = "Status: \(value.status)"
        species.text = "Species: \(value.species)"
        
        switch value.status {
        case .alive:
            contentView.backgroundColor = .systemGreen
        case .dead:
            contentView.backgroundColor = .systemCyan
        case .unknown:
            contentView.backgroundColor = .systemPink
        }
    }
    
    func isFavorite(isBool: Bool) {
        if isBool {
            favoriteButton.alpha = 1
        }
        else{
            favoriteButton.alpha = 0
        }
    }
}

extension RickCollectionViewCell {
    private func makeFavorite() {
        favoriteButton.snp.makeConstraints { make in
            make
                .top
                .equalTo(contentView.safeAreaLayoutGuide)
                .offset(5)
            make
                .centerX
                .equalTo(contentView.snp.centerX)
        }
    }
    
    private func makeImage() {
        image.snp.makeConstraints { make in
            make
                .top
                .equalTo(favoriteButton.snp.bottom)
                .offset(5)
//            make
//                .height
//                .equalTo(contentView.snp.width)
//                .multipliedBy(1/2)
            make
                .width
                //.equalTo(contentView.frame.width/1)
                .equalTo(contentView.snp.width)
                .multipliedBy(1/1.2)
            make
                .centerX
                .equalTo(contentView.snp.centerX)
        }
    }
    
    private func makeName() {
        rickName.snp.makeConstraints { make in
            make
                .top
                .equalTo(image.snp.bottom)
                .offset(5)
            make
                .centerX
                .equalTo(contentView.snp.centerX)
        }
    }
    
    private func makeStatus() {
        status.snp.makeConstraints { make in
            make
                .top
                .equalTo(rickName.snp.bottom)
                .offset(5)
            make
                .centerX
                .equalTo(contentView.snp.centerX)
        }
    }
    
    private func makeSpecies() {
        species.snp.makeConstraints { make in
            make
                .top
                .equalTo(status.snp.bottom)
                .offset(5)
            make
                .centerX
                .equalTo(contentView.snp.centerX)
        }
    }
}
