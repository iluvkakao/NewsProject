//
//  ViewController.swift
//  NewsProject
//
//  Created by Natallia Askerka on 25.08.21.
//

import UIKit
import SafariServices

struct NewsTableViewCellModel{
    var title: String
    var subtitle: String
    var imageURL: String?
    var imageData: Data?
}

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var newsResponse : NewsResponse?
    private let dataFetcher = DataFetcherService()
    private var dataSource = [NewsTableViewCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: NewsTableViewCell.self)
        tableView.tableFooterView = UIView()
        
        createCustomNavigationBar()
        
        dataFetcher.getNews(completion: {[weak self] response in
            guard let self = self, let response = response else {return}
            self.newsResponse = response
            self.configurateDataSourceFrom(response: response)
        })
    
    }

    func configurateDataSourceFrom(response: NewsResponse){

        if let numbers = response.articles?.count {
            for number in 0...numbers-1 {
                dataSource.append(NewsTableViewCellModel(title: response.articles?[number].title ?? "", subtitle: response.articles?[number].description ?? "", imageURL:  response.articles?[number].urlToImage ?? ""))
            }
        }
        tableView.reloadData()
    }
    
    func createCustomNavigationBar() {
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigationItem.title = "Новости"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}


//MARK:- UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: NewsTableViewCell.self, for: indexPath)
        cell.configureWith(model: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        let articles = newsResponse?.articles
        let article = articles?[indexPath.row]
        guard let url = URL(string: article?.url ?? "") else{
            return
        }
        let VC = SFSafariViewController(url: url)
        present(VC, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

