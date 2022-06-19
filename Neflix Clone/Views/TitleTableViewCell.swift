//
//  UpcomingTableViewCell.swift
//  Neflix Clone
//
//  Created by mohamed salah on 09/06/2022.
//

import UIKit

 
class TiltleTableViewCell: UITableViewCell {

    
    static let identifier = "UpcomingTableViewCell"
    
 
    let posterImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let titleLable : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.lineBreakMode = .byWordWrapping
        //label.adjustsFontSizeToFitWidth = true
        //label.minimumScaleFactor = 0.2
        label.numberOfLines=0
        return label
    }()
    let playButton :UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        button.setImage(image, for:.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
   

       
    }
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        contentView.addSubview(posterImage)
        contentView.addSubview(playButton)
        contentView.addSubview(titleLable)

        configureConstraints()
        
    }
    
    
  
    func configureConstraints()
    {
        let posterConstraints = [
        posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        posterImage.topAnchor.constraint(equalTo: contentView.topAnchor ,constant: 30),
        posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -20),
        posterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
     
        let playButtonConstraints = [
        playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor ,constant: -20),
        playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        let TitleConstraints = [
        titleLable.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor ,constant: 15),

        //titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor ,constant: -70),
        titleLable.trailingAnchor.constraint(equalTo: playButton.leadingAnchor ,constant: -10),

        titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(posterConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(TitleConstraints)
       


        
    }
    
    func populateData(data:Title){
        titleLable.text = data.originalName ?? data.originalTitle ?? "Uknown"
        let baseURl = "https://image.tmdb.org/t/p/w500"
        guard let url = URL(string:baseURl+(data.posterPath ?? "")) else{return}
        posterImage.sd_setImage(with: url, completed: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
