//
//  FavoriteVC.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 12.03.2022.
//

import UIKit

class FavoriteVC: UIViewController {
    
    private lazy var context = appDelegate.persistentContainer.viewContext
    
    private var favoriteTable = UITableView()
    
    private lazy var favoriteList = [Favorite]()
    private lazy var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTable.register(FavoriteViewCell.self, forCellReuseIdentifier: FavoriteViewCell.Identifier.path.rawValue)
        getData()
        view.addSubview(favoriteTable)
        view.backgroundColor = .white
        makeTable()
        favoriteTable.delegate = self
        favoriteTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    func favoriVC(data: [String]) {
        self.list = data
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
        DispatchQueue.main.async {
            self.favoriteTable.reloadData()
        }
    }
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteViewCell.Identifier.path.rawValue) as? FavoriteViewCell else {
            return UITableViewCell()
        }
        cell.saveModel(value: list[indexPath.row])
        return cell
    }
}

extension FavoriteVC {
    func makeTable() {
        favoriteTable.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(0)
            make
                .left
                .right
                .equalTo(view)
                .offset(0)
            make
                .bottom
                .equalTo(view.safeAreaLayoutGuide)
                .offset(0)
        }
    }
}