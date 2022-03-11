//
//  RickAndMortyProvider.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 8.03.2022.
//

import Foundation
import UIKit

class RickAndMortyProvider: NSObject, RickAndMortyProviderProtocol {
    
    var delegate: RickAndMortyProviderDelegate?
    var data: [RickAndMortyPresentations] = []
    var detailData: [RickResult] = []
    var isSearch = Bool()
    //var filterData: [RickAndMortyPresentations] = []
    var filterData: [RickResult] = []
    var isLayout = Bool()
    var routerData: [RickResult] = []
    var favName = [String]()
    var arda = [String]()
}

extension RickAndMortyProvider {
    func load(value: [RickResult]) {
        self.routerData = value
        let rickData = value.map(RickAndMortyPresentations.init)
        self.data = rickData
    }
    
    func search(issearch: Bool) {
        self.isSearch = issearch
    }
    
    func layout(islayout: Bool) {
        self.isLayout = islayout
    }
    
    func isFavorite(name: [String]) {
        self.favName = name
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "Name") {
        filterData = routerData.filter() {
            shape in
            let scopeMatch = (scopeButton == "Name" || shape.status.rawValue.lowercased().contains(scopeButton.lowercased()))
                    if(searchText != "")
                    {
                        let searchTextMatch = shape.name.lowercased().contains(searchText.lowercased())
                        return scopeMatch && searchTextMatch
                    }
                    else
                    {
                        return scopeMatch
                    }
        }
    }
}

extension RickAndMortyProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch {
            return filterData.count
                    }
            return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RickCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? RickCollectionViewCell else {
            return UICollectionViewCell()
        }
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 0.9
        if isSearch {
            
            let filterValue = filterData[indexPath.row].name
            if favName.isEmpty {
                cell.saveModel(value: filterData[indexPath.row], isBool: false, list: favName)
            }else{
                for i in favName {
                    if i == filterValue {
                        cell.saveModel(value: filterData[indexPath.row], isBool: true, list: favName)
                    }
                        else{
                    cell.saveModel(value: filterData[indexPath.row], isBool: false, list: favName)
                    }
                }
            }
            
        }else{
            
            let routerValue = routerData[indexPath.row].name
            arda.append(routerValue)
            if favName.isEmpty {
                cell.saveModel(value: routerData[indexPath.row], isBool: false, list: favName)
            }else{
                for i in favName {
                    if i == routerValue {
                        cell.saveModel(value: routerData[indexPath.row], isBool: true, list: favName)
                    }else{
                        cell.saveModel(value: routerData[indexPath.row], isBool: false, list: favName)
                    }
                }
            }
        }
           return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        let colums: CGFloat = 2
        let with = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 20)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        if isLayout {
            let wid: CGFloat = with
            width = wid - 30
            height = wid / 1.60
        }else{
            let wid: CGFloat = (with-50) / colums
            width = wid
            height = wid * 1.45
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        if isSearch {
            print("secilen \(filterData[indexPath.row].name)")
           let filterDataTwo = filterData[indexPath.row]
           //let filterRouter = RickAndMortyDetailPresentations(data: filterDataTwo)
            delegate?.selected(at: filterDataTwo)
        }else{
            print("secilen \(data[indexPath.row].name)")
            let routerDataTwo = routerData[indexPath.row]
            //let routerValue = RickAndMortyDetailPresentations(data: routerDataTwo)
            delegate?.selected(at: routerDataTwo)
        }
    }
}
