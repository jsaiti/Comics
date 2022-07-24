//
//  ComicDetailsViewController.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

class ComicDetailsViewController: ViewModelViewController<ComicDetailsViewModel> {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var explainedLabel: UILabel!
    @IBOutlet private weak var explainButton: UIButton!
    
    var comic: Comic! {
        didSet {
            viewModel.comic = comic
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentData()
    }
    
    private func presentData() {
        title = viewModel.navigationTitle
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        descriptionLabel.text = viewModel.description
        
        imageView.downloadImage(urlString: viewModel.imageURL, showIndicator: true)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        
    }
    
    @IBAction func explainAction(_ sender: UIButton) {
        explainedLabel.text = viewModel.explanation
        sender.isHidden = true
    }
}
