//
//  ComicTableViewCell.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

class ComicTableViewCell: UITableViewCell, CellIdentifiable {

    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var labelComicNumber: UILabel!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appearance()
    }

    private func appearance() {
        bgView.addShadow()
        imgView.addShadow(color: .lightGray)
    }
    
    func setup(with viewModel: ComicTableViewCellViewModel) {
        labelComicNumber.text = viewModel.comicNumber
        labelTitle.text = viewModel.title
        labelDate.text = viewModel.date
        imgView.image = nil
        imgView.downloadImage(urlString: viewModel.imageUrl, showIndicator: true)
    }
}
