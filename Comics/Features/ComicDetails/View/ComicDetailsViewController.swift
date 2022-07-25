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
    @IBOutlet private weak var titleLabel: LabelLargeTitle!
    @IBOutlet private weak var dateLabel: LabelH3!
    @IBOutlet private weak var descriptionLabel: LabelBody!
    @IBOutlet private weak var explainedLabel: LabelBody!
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
        imageView.downloadImage(urlString: viewModel.imageURL, placeholder: viewModel.savedImage, showIndicator: false) { [weak self] image in
            self?.viewModel.saveImage(image: image)
        }
        favoriteButton.setImage(viewModel.favoriteIcon, for: .normal)
        viewModel.didChangeFavoriteState = { [weak self] image in
            self?.favoriteButton.setImage(image, for: .normal)
        }
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        // Description
        let firstActivityItem = viewModel.shareInformation
        var items:[Any] = [firstActivityItem]
        
        // If you want to use an image
        if let image: UIImage = imageView.image {
            items.append(image)
        }
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: items, applicationActivities: nil)
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = sender
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [UIActivity.ActivityType.message] as? UIActivityItemsConfigurationReading
        activityViewController.isModalInPresentation = true
        
        self.present(activityViewController, animated: true)
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        viewModel.handleFavorite()
    }
    
    @IBAction func explainAction(_ sender: UIButton) {
        explainedLabel.text = viewModel.explanation
        sender.isHidden = true
    }
}
