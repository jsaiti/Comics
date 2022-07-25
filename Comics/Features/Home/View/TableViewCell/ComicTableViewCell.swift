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
    @IBOutlet private weak var labelComicNumber: LabelTitle!
    @IBOutlet private weak var labelTitle: LabelBody!
    @IBOutlet private weak var labelDate: LabelH3!
    
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
        imgView.image = UIImage(named: "no-image")
        imgView.downloadImage(urlString: viewModel.imageUrl, placeholder: viewModel.savedImage, showIndicator: false)
    }
}
