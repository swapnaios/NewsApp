//
//  DetailsViewController.swift
//  USNewsAPP
//
//  Created by Swapna Mutchu on 23/03/25.
//

import UIKit
import SDWebImage
import MBProgressHUD

class DetailsViewController: UIViewController, UIScrollViewDelegate {
    
    var titleString, descriptionString, authorName, articleURL,imageURL, content, publishedAt: String?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    let newsViewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        self.navigationController?.title = "Details"
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 200)
        
        view.layoutIfNeeded()
        contentView.layoutIfNeeded()
        scrollView.layoutIfNeeded()
        
        
        self.titleLabel.text = titleString
        self.descriptionLabel.text = descriptionString
        self.authorLabel.text = authorName
        self.contentLabel.text = content
        self.publishedAtLabel.text = publishedAt
        
        self.newsImageView?.sd_setImage(with: URL(string: imageURL ?? "")) { (image, error, cache, urls) in
            if (error != nil) {
                self.newsImageView?.image = UIImage(systemName: "newspaper")
                self.newsImageView?.tintColor = .systemOrange
            } else {
                self.newsImageView?.image = image
            }
        }
        
        let articleID = convertToArticleID(from: articleURL!)
        print(articleID)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        newsViewModel.fetchLikes(articleID: articleID) { likes in
            print("Likes:", likes ?? 0)
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.likesLabel.text = "\(likes?.numberOfLikes ?? 0)"
            }
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        newsViewModel.fetchComments(articleID: articleID) { comments in
            print("Comments:", comments ?? 0)
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.commentsLabel.text = "\(comments?.numberOfComments ?? 0)"
            }
        }
    }
    
    func convertToArticleID(from url: String) -> String {
        guard let urlObject = URL(string: url) else { return "" }
        
        // Remove scheme (https:// or http://)
        var articleID = urlObject.host ?? ""
        articleID += urlObject.path.replacingOccurrences(of: "/", with: "-")
        
        return articleID
    }
}
