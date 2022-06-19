//
//  CollectionViewTableViewCell.swift
//  Neflix Clone
//
//  Created by mohamed salah on 03/06/2022.
//

import UIKit


protocol CollectionViewTableViewCellDelegate : AnyObject{
    func didCellTapped (videoUrl : String)
}

class CollectionViewTableViewCell: UITableViewCell,UICollectionViewDelegate , UICollectionViewDataSource {

    static let identifier = "CollectionViewTableViewCell"
    
    private var titles:[Title] = [Title]()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    weak var delegate : CollectionViewTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
         
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configureCellsWithDate(with titles:[Title]){
        self.titles = titles
        
        DispatchQueue.main.async {
            [weak self] in
            self?.collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else{return UICollectionViewCell()}
        
        guard let posterPath = titles[indexPath.row].posterPath else {
           return UICollectionViewCell()
        }
        
        cell.configurePosterImage(with: posterPath)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)
        let query = titles[indexPath.row].originalName ?? titles[indexPath.row].originalTitle ?? ""
        ApiCaller.shared.getYoutubeTrailer(query: query){
            result in
            switch result {
            case .success(let youtubeResponse):
                self.delegate?.didCellTapped(videoUrl: youtubeResponse.items[0].id.videoId)
                
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
    }
}


 


