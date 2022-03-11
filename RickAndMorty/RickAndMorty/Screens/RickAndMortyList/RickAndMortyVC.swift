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
    
    private lazy var searchBar: UISearchController = {
       let search = UISearchController()
       
        return search
    }()
    private lazy var segmentControl: UISegmentedControl = {
       var segment = UISegmentedControl()
        let items = [ListContants.SegmentItems.grid.rawValue, ListContants.SegmentItems.list.rawValue]
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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegeta()
        presenter?.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func initDelegeta() {
        collection.register(
        RickCollectionViewCell.self,
        forCellWithReuseIdentifier: RickCollectionViewCell.Identifier.path.rawValue
                            )
        searchBar.searchResultsUpdater = self
        provider.delegate = self
        collection.dataSource = provider
        collection.delegate = provider
        searchBar.searchBar.placeholder = ListContants.SearchBar.placeHolder.rawValue
        searchBar.searchBar.scopeButtonTitles = [ListContants.SearchBar.scopeTitleAll.rawValue,
                                                 ListContants.SearchBar.scopeTitleAlive.rawValue,
                                                 ListContants.SearchBar.scopeTitleDead.rawValue,
                                                 ListContants.SearchBar.scopeTitleunknown.rawValue
                                                 ]
        configure()
        favoriBarButton()
        createSegmentConntrol()
    }
    
    func getData() {
        list.removeAll()
    do {
        favoriteList = try context.fetch(Favorite.fetchRequest())
    }catch{
        print("error")
    }
    for k in favoriteList {
        guard let temp = k.name else { return }
        list.append(temp)
    }
        provider.isFavorite(name: list)
        DispatchQueue.main.async {
            self.collection.reloadData()
        }
}
    
    func favoriBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(goToFavorites(_:)))
    }
    
    @objc func goToFavorites(_ navigationItem: UIBarButtonItem) {
        let view = FavoriteVC()
        self.show(view, sender: nil)
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
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
            
        case .rickAndMortyError(let error):
            let errorAlert = UIAlertController(title: ListContants.Alert.alertTitle.rawValue,
                                               message: error ,
                                               preferredStyle: .alert
                                                )
            let errorAction = UIAlertAction(title: ListContants.Alert.actionTitle.rawValue,
                                            style: .cancel
                                            )
            errorAlert.addAction(errorAction)
            self.present(errorAlert, animated: true)
        case .title(let title):
            self.title = title
        }
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
