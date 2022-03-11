//
//  RickAndMortyDetailVC.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 6.03.2022.
//

import UIKit
import AlamofireImage
import SnapKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class RickAndMortyDetailVC: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    var faoriList = [Favorite]()
    
    private let rickImage = UIImageView()
    private let rickName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let rickStatus: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let rickSpecies: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let rickGender: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let rickLocation: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let rickEpisode: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let rickOrigin: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let favoriButton: UIButton = {
        var button = UIButton()
        button.setTitle("Add to Favorite", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()

    var presenter: RickAndMortyDetailPresenter?
    var episode: [String] = []
    var sendName = String()
    var cell: RickCollectionViewCell?
    var a =  [String]()
    var favoriteList = [Favorite]()
    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.load()
        configure()
        view.backgroundColor = .lightGray
    }
    
    func configure() {
        view.addSubview(rickImage)
        view.addSubview(rickName)
        view.addSubview(rickStatus)
        view.addSubview(rickSpecies)
        view.addSubview(rickGender)
        view.addSubview(rickLocation)
        view.addSubview(rickEpisode)
        view.addSubview(rickOrigin)
        view.addSubview(favoriButton)
        makeImage()
        makeName()
        makeStatus()
        makeSpecies()
        makeGender()
        makeLocation()
        makeEpisode()
        makeOrigin()
        makeButton()
        getData()
        clickButton()
    }
    
    func getData() {
    do {
        favoriteList = try context.fetch(Favorite.fetchRequest())
    }catch{
        print("error")
    }

    for k in favoriteList {
        //print( " asdasdasd: \(k.name ?? "")")
        if let temp = k.name {
            list.append(temp)
        }
        
    }
}
    
    func clickButton() {
        favoriButton.addTarget(self, action: #selector(addFavorite(_:)), for: .touchUpInside)
    }
    
    @objc func addFavorite(_ favoriButton: UIButton) {
        let favorite = Favorite(context: context)
        if list.contains(sendName) {
            print("zaten var ")
        }else{
            favorite.name = sendName
            appDelegate.saveContext()
            print("eklendi")
        }
//        print("eklendi")
//        favorite.name = sendName
//        appDelegate.saveContext()
    }
}

extension RickAndMortyDetailVC: RickAndMortyDetailViewProtocol {
    func update(_ presentation: RickAndMortyDetailPresentations) {
        self.title = presentation.name
        rickImage.af.setImage(withURL: URL(string: presentation.image)!)
        rickName.text = "Name: \(presentation.name)"
        self.sendName = presentation.name
        rickStatus.text = "Status: \(presentation.status)"
        rickSpecies.text = "Species: \(presentation.species)"
        rickGender.text =  "Gender: \(presentation.gender)"
        rickLocation.text = "Location: \(presentation.location)"
        episode =  presentation.episode
        let episodeCount = episode.count
        rickEpisode.text = "Episode Count: \(episodeCount)"
        rickOrigin.text = "Origin: \(presentation.origin)"
    }
}

extension RickAndMortyDetailVC {
    private func makeImage() {
        rickImage.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(10)
            make
                .height
                .equalTo(rickImage.snp.width)
                .multipliedBy(1/1.5)
//            make
//                .width
//                .equalTo(view.snp.width)
//                .multipliedBy(1/1.1)
            make
                .centerX
                .equalTo(view.snp.centerX)
        }
    }
    
    private func makeName() {
        rickName.snp.makeConstraints { make in
            make
                .top
                .equalTo(rickImage.snp.bottom)
                .offset(15)
            make
                .centerX
                .equalTo(view.snp.centerX)
        }
    }
    
    private func makeStatus() {
        rickStatus.snp.makeConstraints { make in
            make
                .top
                .equalTo(rickName.snp.bottom)
                .offset(15)
            make
                .centerX
                .equalTo(view.snp.centerX)
        }
    }
    
    private func makeSpecies() {
        rickSpecies.snp.makeConstraints { make in
            make
                .top
                .equalTo(rickStatus.snp.bottom)
                .offset(15)
            make
                .centerX
                .equalTo(view.snp.centerX)
        }
    }
    
    private func makeGender() {
        rickGender.snp.makeConstraints { make in
            make
                .top
                .equalTo(rickSpecies.snp.bottom)
                .offset(15)
            make
                .centerX
                .equalTo(view.snp.centerX)
        }
    }
    
    private func makeLocation() {
        rickLocation.snp.makeConstraints { make in
            make
                .top
                .equalTo(rickGender.snp.bottom)
                .offset(15)
            make
                .centerX
                .equalTo(view.snp.centerX)
        }
    }
    
    private func makeEpisode() {
        rickEpisode.snp.makeConstraints { make in
            make
                .top
                .equalTo(rickLocation.snp.bottom)
                .offset(15)
            make
                .centerX
                .equalTo(view.snp.centerX)
        }
    }
    
    private func makeOrigin() {
        rickOrigin.snp.makeConstraints { make in
            make
                .top
                .equalTo(rickEpisode.snp.bottom)
                .offset(15)
            make
                .centerX
                .equalTo(view.snp.centerX)
        }
    }
    
    private func makeButton() {
        favoriButton.snp.makeConstraints { make in
            make
                .bottom
                .equalTo(view.safeAreaLayoutGuide)
                .offset(-210)
            make
                .centerX
                .equalTo(view.snp.centerX)
        }
    }
}
