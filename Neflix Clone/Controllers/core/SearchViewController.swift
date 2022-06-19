//
//  SearchViewController.swift
//  Neflix Clone
//
//  Created by mohamed salah on 03/06/2022.
//

import UIKit
import MBProgressHUD
class SearchViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchResultsUpdating{
    
    var titles : [Title] = [Title]();
    let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TiltleTableViewCell.self, forCellReuseIdentifier: TiltleTableViewCell.identifier)
        return table
    }()
    
    let searchContoller : UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a Movie or TV show"
        controller.searchBar.searchBarStyle = .minimal
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoverTable)
        navigationItem.searchController = searchContoller
        navigationController?.navigationBar.tintColor = .white
        
        discoverTable.delegate = self
        discoverTable.dataSource = self
    
        searchContoller.searchResultsUpdater = self
        
        
        fetchDiscoverData()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
   func fetchDiscoverData(){
       MBProgressHUD.showAdded(to:self.view , animated:true )//to show

       ApiCaller.shared.getDiscover{
            [weak self] result in
            switch(result){
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async{
                    MBProgressHUD.hide(for: self!.view, animated: true)

                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = discoverTable.dequeueReusableCell(withIdentifier: TiltleTableViewCell.identifier, for: indexPath) as? TiltleTableViewCell else{
           return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        
        cell.populateData(data: title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        MBProgressHUD.showAdded(to:self.view , animated:true )//to show

        let query = titles[indexPath.row].originalName ?? titles[indexPath.row].originalTitle ?? ""
        
        ApiCaller.shared.getYoutubeTrailer(query: query){
            result in
            switch result {
            case .success(let youtubeResponse):
                
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)

                    let vc = TitleDetailsViewController()
                    vc.configureData(videoURL: youtubeResponse.items[0].id.videoId)
                self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {
                  return
              }
        
        ApiCaller.shared.search(query: query) {
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
 
                    resultController.titles = titles
                    resultController.searchCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
              
    }
}
