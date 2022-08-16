//
//  ImageDownloader.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

class ImageDownloader: NSObject {
    
    static let shared = ImageDownloader()
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [(UIImage?) -> Swift.Void]]()
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        return  URLSession(configuration: config)
    }()
    
    final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    // Returns the cached image if available, otherwise asynchronously loads and caches it.
    final func load(url: URL, completion: @escaping (UIImage?) -> Swift.Void) {
        let url = url as NSURL
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        // In case there are more than one requestor for the image, we append their completion block.
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
           return
        } else {
            loadingResponses[url] = [completion]
        }
        // Go fetch the image.
        urlSession.dataTask(with: url as URL) { data, _, error in
            // Check for the error, then data and try to create the image.
            guard let responseData = data, let image = UIImage(data: responseData),
                let blocks = self.loadingResponses[url], error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            // Cache the image.
            self.cachedImages.setObject(image, forKey: url, cost: responseData.count)
            // Iterate over each requestor for the image and pass it back.
            for (index, block) in blocks.enumerated() {
                DispatchQueue.main.async {
                    block(image)
                }
                // Remove all closures after the job is done
                if index == blocks.count - 1 {
                    self.loadingResponses.removeValue(forKey: url)
                }
            }
        }
        .resume()
    }
}
