//
//  SearchResultViewController.swift
//  Neflix Clone
//
//  Created by mohamed salah on 17/06/2022.
//

import UIKit

class SearchResultViewController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    public var titles:[Title] = [Title]()
    
    public let searchCollectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3 - 10 , height: 200)
        layout.minimumInteritemSpacing = 0
         
        
        let collection = UICollectionView(frame: .zero,collectionViewLayout: layout)
       
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        return collection
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        
        view.addSubview(searchCollectionView)
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchCollectionView.frame = view.bounds
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configurePosterImage(with:titles[indexPath.row].posterPath ?? "")

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // collectionView.deselectItem(at: indexPath, animated: true)
        let query = titles[indexPath.row].originalName ?? titles[indexPath.row].originalTitle ?? ""
        ApiCaller.shared.getYoutubeTrailer(query: query){
            result in
            switch result {
            case .success(let youtubeResponse):
                
                DispatchQueue.main.async {
                    let vc = TitleDetailsViewController()
                    vc.configureData(videoURL: youtubeResponse.items[0].id.videoId)
                self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
    }
}
