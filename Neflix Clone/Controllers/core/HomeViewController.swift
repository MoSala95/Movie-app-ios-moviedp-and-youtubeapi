//
//  HomeViewController.swift
//  Neflix Clone
//
//  Created by mohamed salah on 03/06/2022.
//

import UIKit
import Foundation
import MBProgressHUD

enum SetctionsEnum : Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController ,CollectionViewTableViewCellDelegate {

    
    private let homeFeedTable : UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
  
    let sections:[String] = ["Trending Movies","Trending TV","Popular","Upcoming Movies","Top Rated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground

        view.addSubview(homeFeedTable)
        homeFeedTable.delegate=self
        homeFeedTable.dataSource=self
        
        homeFeedTable.tableHeaderView = HeroHeaderUIView(frame: CGRect(x:0, y:0, width:view.bounds.width, height:350))
        configureNavBar()
        getTrendingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeFeedTable.frame = view.bounds
       
    }
   
   func configureNavBar(){
       
       var image = UIImage(named:"netflix")
    
       image = image?.resizeImageTo(size: CGSize(width: 25, height: 35))
       image = image?.withRenderingMode(.alwaysOriginal)
       
       navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
       
       navigationItem.rightBarButtonItems = [
        UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
        UIBarButtonItem(image:  UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
       ]
       navigationController?.navigationBar.tintColor = .white
        
    }
    
    private func getTrendingMovies()
    {
        ApiCaller.shared.getTrendingTv(completion: {results in
            switch results {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }
        } )
    }
    
    func didCellTapped(videoUrl: String) {
        DispatchQueue.main.async {
            let vc = TitleDetailsViewController()
            vc.configureData(videoURL: videoUrl)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    


}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier,for: indexPath) as? CollectionViewTableViewCell else {
            MBProgressHUD.hide(for: self.view, animated: true)

            return UITableViewCell()
            
        }
        cell.delegate = self
        
    
        MBProgressHUD.showAdded(to:self.view , animated:true )//to show

        switch indexPath.section{
        
        case SetctionsEnum.TrendingMovies.rawValue:
            ApiCaller.shared.getTrendingMovies(completion: { result in
                switch result{
                case .success(let titles):
                    cell.configureCellsWithDate(with: titles)
                case .failure(let error):
                    print(error)
                }
            })
        case SetctionsEnum.TrendingTV.rawValue:
            ApiCaller.shared.getTrendingTv(completion: { result in
                switch result{
                case .success(let titles):
                    cell.configureCellsWithDate(with: titles)
                case .failure(let error):
                    print(error)
                }
            })
        case SetctionsEnum.Popular.rawValue:
            ApiCaller.shared.getPopular(completion: { result in
                switch result{
                case .success(let titles):
                    cell.configureCellsWithDate(with: titles)
                case .failure(let error):
                    print(error)
                }
            })
        case SetctionsEnum.Upcoming.rawValue:
            ApiCaller.shared.getUpcomingMovies(completion: { result in
                switch result{
                case .success(let titles):
                    cell.configureCellsWithDate(with: titles)
                case .failure(let error):
                    print(error)
                }
            })
        case SetctionsEnum.TopRated.rawValue:
            ApiCaller.shared.getTopRated(completion: { result in
                switch result{
                case .success(let titles):
                    cell.configureCellsWithDate(with: titles)
                case .failure(let error):
                    print(error)
                }
            })
            
         default:
            UITableViewCell()
            
        }
        MBProgressHUD.hide(for: self.view, animated: true)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else{return}
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight:.semibold)
       // header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.CapitalizeFirstLetter()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        
    }
}

extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
