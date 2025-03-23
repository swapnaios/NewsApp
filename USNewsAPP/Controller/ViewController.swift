//
//  ViewController.swift
//  USNewsAPP
//
//  Created by Swapna Mutchu on 23/03/25.
//

import UIKit
import SDWebImage
import MBProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let newsViewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.sectionHeaderTopPadding = 0
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        newsViewModel.getLatestNewsAPI {
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsViewModel.newsArticlesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell
 
        tableViewCell?.titleLabel.text = newsViewModel.newsArticlesArray[indexPath.section].title ?? ""
        tableViewCell?.authorLabel.text = String("Author: \(newsViewModel.newsArticlesArray[indexPath.section].author ?? "Unknown")")
     
        let imageURL = newsViewModel.newsArticlesArray[indexPath.section].urlToImage
        
        tableViewCell?.newsImageView?.sd_setImage(with: URL(string: imageURL ?? "")) { (image, error, cache, urls) in
            if (error != nil) {
                tableViewCell?.newsImageView?.image = UIImage(systemName: "newspaper")
                tableViewCell?.newsImageView?.tintColor = .systemOrange
            } else {
                tableViewCell?.newsImageView?.image = image
            }
        }
                
        tableViewCell?.layer.borderColor = UIColor.black.cgColor
        tableViewCell?.layer.borderWidth = 1
        tableViewCell?.layer.cornerRadius = 8
        tableViewCell?.clipsToBounds = true
        
        return tableViewCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        detailsViewController?.titleString = newsViewModel.newsArticlesArray[indexPath.section].title ?? ""
        detailsViewController?.descriptionString = newsViewModel.newsArticlesArray[indexPath.section].description ?? ""
        detailsViewController?.authorName = String("Author name: \(newsViewModel.newsArticlesArray[indexPath.section].author ?? "Unknown")")
        detailsViewController?.imageURL = newsViewModel.newsArticlesArray[indexPath.section].urlToImage
        detailsViewController?.articleURL = newsViewModel.newsArticlesArray[indexPath.section].url
        detailsViewController?.publishedAt = String("Published At: \(newsViewModel.newsArticlesArray[indexPath.section].publishedAt ?? "Unknown")")
        detailsViewController?.content = newsViewModel.newsArticlesArray[indexPath.section].content ?? ""
        self.navigationController?.pushViewController(detailsViewController!, animated: true)
    }
}

