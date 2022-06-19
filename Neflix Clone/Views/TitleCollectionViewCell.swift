//
//  TitleCollectionViewCell.swift
//  Neflix Clone
//
//  Created by mohamed salah on 08/06/2022.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    let posterImageView : UIImageView = {
        let image: UIImageView = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds

    }
    
    public func configurePosterImage (with urlPath:String){
        let baseURl = "https://image.tmdb.org/t/p/w500"
        guard let url = URL(string:baseURl+urlPath) else{return}
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
}
