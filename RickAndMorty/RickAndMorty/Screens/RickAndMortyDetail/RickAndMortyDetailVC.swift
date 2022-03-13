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
    
    private lazy var rickImage: UIImageView = {
        let image = UIImageView()
        view.addSubview(image)
        return image
    }()
    
    private lazy var rickName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        return label
    }()
    
    private lazy var rickStatus: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        return label
    }()
    
    private lazy var rickSpecies: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        return label
    }()
    
    private lazy var rickGender: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        return label
    }()
    
    private lazy var rickLocation: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        return label
    }()
    
    private lazy var rickEpisode: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        return label
    }()
    
    private lazy var rickOrigin: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        return label
    }()
    
    private lazy var favoriButton: UIButton = {
        var button = UIButton()
        button.setTitle(DetailConstants.ButtonConstants.addButton.rawValue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(button)
        return button
    }()
    
    private lazy var deleteFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle(DetailConstants.ButtonConstants.deleteButton.rawValue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(button)
        return button
    }()

    var presenter: RickAndMortyDetailPresenter?
    var episode: [String] = []
    var sendName = String()
    var imageName = String()
    var favoriteList = [Favorite]()
    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.load()
        configure()
        view.backgroundColor = .lightGray
    }
    
    func configure() {
        makeImage()
        makeName()
        makeStatus()
        makeSpecies()
        makeGender()
        makeLocation()
        makeEpisode()
        makeOrigin()
        makeButton()
        makeDeleteButton()
        getData()
        addClickButton()
        addDeleteButton()
    }
    
    func getData() {
    do {
        favoriteList = try context.fetch(Favorite.fetchRequest())
    }catch{
        print("error")
    }
    for k in favoriteList {
        if let temp = k.name {
            list.append(temp)
        }
        
    }
}
    
    func addClickButton() {
        favoriButton.addTarget(self, action: #selector(addFavorite(_:)), for: .touchUpInside)
    }
    
    @objc func addFavorite(_ favoriButton: UIButton) {
        let favorite = Favorite(context: context)
        if list.contains(sendName) {
        }else{
            favorite.name = sendName
            favorite.imageName = imageName
            appDelegate.saveContext()
        }
    }
    
    func addDeleteButton() {
        deleteFavoriteButton.addTarget(self, action: #selector(addDelete(_:)), for: .touchUpInside)
    }
    
    @objc func addDelete(_ deleteFavoriteButton: UIButton) {
        for (index, i) in list.enumerated() {
            if i == sendName {
                let favori = favoriteList[index]
                context.delete(favori)
                appDelegate.saveContext()
            }
        }
    }
}

extension RickAndMortyDetailVC: RickAndMortyDetailViewProtocol {
    func update(_ presentation: RickAndMortyDetailPresentations) {
        self.title = presentation.name
        rickImage.af.setImage(withURL: URL(string: presentation.image)!)
        self.imageName = presentation.image
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
                .equalTo(view.frame.height/2.4)
            make
                .width
                .equalTo(view.frame.width/1.4)
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
                .top
                .equalTo(rickOrigin.snp.bottom)
                .offset(15)
//            make
//                .width
//                .equalTo(view.frame.height/2.3)
            make
                .centerX
                .equalTo(view.frame.width/2.8)
        }
    }
    
    private func makeDeleteButton() {
        deleteFavoriteButton.snp.makeConstraints { make in
            make
                .top
                .equalTo(rickOrigin.snp.bottom)
                .offset(15)
            make
                .left
                .equalTo(favoriButton.snp.right)
                .offset(20)
        }
    }
}
