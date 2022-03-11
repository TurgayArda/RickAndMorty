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
        
    let context = appDelegate.persistentContainer.viewContext
    
    private lazy var rickName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let playButton  = UIButton(type: .system)
        let paperPlane = UIImage(systemName: "star.fill")
//        let arda  = UIButton(type: .system)
//        let ardapaper = UIImage(systemName: "heart.fill")
        playButton.alpha = 1
        playButton.setImage(paperPlane, for: .normal)
//        arda.setImage(ardapaper, for: .normal)
        return playButton
    }()
    
    private let status: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let species: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let image = UIImageView()
    
    var isListFlowLayout: Bool = false
    var favName = [String]()
    var comName = String()
    var dizi = [String]()
    var favoriteList = [Favorite]()
    var list = [String]()
    var bo = Bool()
    
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
       
        addSubview(favoriteButton)
        addSubview(image)
        addSubview(rickName)
        addSubview(status)
        addSubview(species)
        makeImage()
        makeName()
        makeStatus()
        makeSpecies()
        makeFavorite()
        
    }

    func saveModel(value: RickResult, isBool: Bool, list: [String]) {
        rickName.text = "Name: \(value.name)"
        self.comName = value.name
        dizi.append(comName)
       image.af.setImage(withURL: URL(string: value.image)!)
       status.text = "Status: \(value.status)"
        species.text = "Species: \(value.species)"
        self.list = list
        //self.bo = isBool
        
//        if isBool {
//            for i in list {
//                if i == comName {
//
//                }
//            }
//        }
//
//        if isBool {
//            for i in list {
//                if dizi.contains(i) {
//                    //favoriteButton.alpha = 1
//                    print("sisli")
//                    bo = true
//                }
//            }
//        }
//        else{
//            for i in list {
//                if dizi.contains(i) {
//                    print("arda")
//                }else{
//                    //favoriteButton.alpha = 0
//                    bo = false
//                }
//            }
//       }
       
    }
    
    func isFavorite(bool: Bool, name: [String]) {
        if bool {
            for i in name {
                if dizi.contains(i) {
                    favoriteButton.alpha = 1
                }
            }
        }else{
            favoriteButton.alpha = 0
        }
    }

//
//    func vericek() {
//        do {
//            favoriteList = try context.fetch(Favorite.fetchRequest())
//        }catch{
//            print("error")
//        }
//
//        for k in favoriteList {
//            guard let temp = k.name else { return }
//            if dizi.contains(temp) {
//                print("yildiz bas")
//            }else{
//                //print("yildiz basma")
//            }
//            if k.name == comName {
//                favoriteButton.alpha = 1
//            }
//            //print(k.name!)
//        }
//    }
    
//    func verisil() {
//
//    }

    func flowLayot(value: Bool) {
        self.isListFlowLayout = value
        //hadi()
    }
    
//        func getData() {
//        do {
//            favoriteList = try context.fetch(Favorite.fetchRequest())
//        }catch{
//            print("error")
//        }
//
//        for k in favoriteList {
//            if k.name == comName {
//                favoriteButton.alpha = 1
//            }
//        }
//            print("fav listesi: \(list)")
//    }
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
//                .equalTo(image.snp.width)
//                .multipliedBy(1/1)
            make
                .width
                .equalTo(contentView.snp.width)
                .multipliedBy(1/1.1)
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
