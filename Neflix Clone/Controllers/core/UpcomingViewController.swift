//
//  UpcomingViewController.swift
//  Neflix Clone
//
//  Created by mohamed salah on 03/06/2022.
//

import UIKit
import MBProgressHUD
class UpcomingViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
   
    var titles:[Title] = [Title]()
    
    let tableView : UITableView = {
        let table = UITableView(frame: .zero)
        table.register(TiltleTableViewCell.self, forCellReuseIdentifier: TiltleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchUpcomingData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        

    }
    
    func fetchUpcomingData(){
        MBProgressHUD.showAdded(to:self.view , animated:true )//to show

        ApiCaller.shared.getUpcomingMovies(completion: {
           [weak self] result in
            switch result{
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    MBProgressHUD.hide(for: self!.view, animated: true)
                    //self?.tableView.contentInset = UIEdgeInsets(top: 40,left: 0,bottom: 0,right: 0)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
           

        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TiltleTableViewCell.identifier, for: indexPath) as? TiltleTableViewCell else{
            return UITableViewCell()
        }
        cell.populateData(data: titles[indexPath.row])
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

}
