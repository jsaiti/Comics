//
//  UIImageViewExtension.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

extension UIImageView {
    func downloadImage(urlString: String?, placeholder: UIImage? = nil, showIndicator: Bool, onCompletion: ((_ image: UIImage) -> Void)? = nil) {
        guard let url = URL(string: urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            self.image = placeholder
            return
        }
        var indicator: UIActivityIndicatorView?
        if showIndicator {
            indicator = UIActivityIndicatorView(style: .medium)
            indicator?.hidesWhenStopped = true
            if let indicator = indicator {
                indicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
                self.addSubview(indicator)
                indicator.startAnimating()
            }
        }
        ImageDownloader.shared.load(url: url) { [weak self] image in
            indicator?.stopAnimating()
            if let image = image {
                self?.image = image
                onCompletion?(image)
            } else {
                self?.image = placeholder
            }
        }
    }
}
