//
//  RickAndMortyVC.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 6.03.2022.
//

import UIKit
import SnapKit

class RickAndMortyVC: UIViewController, RickAndMortyProviderDelegate {
    
    let context = appDelegate.persistentContainer.viewContext
    
    private lazy var searchBar = UISearchController()
    private lazy var segmentControl: UISegmentedControl = {
       var segment = UISegmentedControl()
        let items = ["Grid", "List"]
        segment = UISegmentedControl(items: items)
        segment.backgroundColor = .purple
        return segment
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .lightGray
        return collectionView
    }()
    
    private var data: [RickResult] = []
   
    
    var presenter: RickAndMortyPresenterProtocol?
    var isListFlowLayout = Bool()
    var isSearch = Bool()
    var provider: RickAndMortyProvider = RickAndMortyProvider()
    var router: RickAndMortyRouterProtocol?
    var favoriteList = [Favorite]()
    var list = [String]()
    var del: Int!
    var cell: RickCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        searchBar.searchBar.scopeButtonTitles = ["Name","Alive","Dead","unknown"]
        searchBar.searchResultsUpdater = self
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.enablesReturnKeyAutomatically = false
        searchBar.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        searchBar.searchBar.placeholder = "ARA"
        provider.delegate = self
        collection.dataSource = provider
        collection.delegate = provider
        createSegmentConntrol()
        collection.register(
        RickCollectionViewCell.self,
        forCellWithReuseIdentifier: RickCollectionViewCell.Identifier.path.rawValue
    )
        presenter?.load()
        //getData()
        //deleteData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    
    func getData() {
    do {
        favoriteList = try context.fetch(Favorite.fetchRequest())
    }catch{
        print("error")
    }

    for k in favoriteList {
        guard let temp = k.name else { return }
        //list.append(k.name ?? "")
        list.append(temp)
        //list.append(k.name ?? "")
    }
        print("fav listesi: \(list)")
        del = list.count
        //provider.isFavorite(name: list)
       //if list.contains()
        //cell?.isFavorite(bool: true, name: <#T##[String]#>)

        DispatchQueue.main.async {
            self.collection.reloadData()
        }
}
    
    func deleteData() {
        for i in 0...1 {
            let fav = favoriteList[i]
            context.delete(fav)
            appDelegate.saveContext()
        }
//        let kis = favoriteList[0]
//        context.delete(kis)
//        appDelegate.saveContext()
    }
    
    func createSegmentConntrol() {
            segmentControl.addTarget(self, action: #selector(click(_:)), for: .valueChanged)
            segmentControl.selectedSegmentIndex = 0
            segmentControl.translatesAutoresizingMaskIntoConstraints = false
        }
        
        @objc func click(_ segmentControl: UISegmentedControl) {
            switch segmentControl.selectedSegmentIndex {
            case 0:
                isListFlowLayout = false
            default:
                isListFlowLayout = true
            }
            DispatchQueue.main.async {
                self.collection.reloadData()
                self.provider.layout(islayout: self.isListFlowLayout)
            }
           
        }
    
    func configure() {
        navigationItem.searchController = searchBar
        view.addSubview(segmentControl)
        view.addSubview(collection)
        view.backgroundColor = .white
        makeSegment()
        makeCollection()
    }
    
    func selected(at select: RickResult) {
        router?.navigate(to: .detail(select))
        
    }
}

extension RickAndMortyVC: RickAndMortyViewDelegate {
    func handleOutPut(_ output: RickAndMortyPresenterOutPut) {
        switch output {
        case .rickAndMortyList(let array):
            self.data = array
            provider.load(value: array)
            provider.isFavorite(name: list)
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
            
        case .rickAndMortyError(let error):
            let errorAlert = UIAlertController(title: "hata",
                                               message: error ,
                                               preferredStyle: .alert
                                                )
            let errorAction = UIAlertAction(title: "hata",
                                            style: .cancel
                                            )
            errorAlert.addAction(errorAction)
            self.present(errorAlert, animated: true)
        case .title(let title):
            self.title = title
        }
        //cell?.isFavorite(name: list)
    }
}

extension RickAndMortyVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
           isSearch = searchBar.isActive
           provider.search(issearch: isSearch)
           let searchBar = searchController.searchBar
           let selectedScope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
           let searchText = searchBar.text!
        provider.filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: selectedScope)
        DispatchQueue.main.async {
            self.collection.reloadData()
            
        }
    }
}
extension RickAndMortyVC {
    func makeSegment() {
        segmentControl.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(5)
            make
                .centerX
                .equalTo(view.snp.centerX)
        }
    }
    
    func makeCollection() {
        collection.snp.makeConstraints { make in
            make
                .top
                .equalTo(segmentControl.snp.bottom)
                .offset(5)
            make
                .left
                .equalTo(view)
                .offset(5)
            make
                .right
                .equalTo(view)
                .offset(5)
            make
                .bottom
                .equalTo(view.safeAreaLayoutGuide)
                .offset(0)
        }
    }
}
