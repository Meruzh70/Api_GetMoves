//
//  MoveCell.swift
//  AlamofayerExample
//
//  Created by XchoBeglaryan on 10.07.21.
//

import UIKit
import Kingfisher

class MovesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var voteLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(input: MoveResalut) {
        
        setImage(imagePath: Base_IMAGE_URL.prod.rawValue + input.backdrop_path)
        titleLbl.text = input.title
        voteLbl.text = "\(input.vote_average)"
    }
    
    func setImage(imagePath: String) {
        
        let url = URL(string: imagePath)
        let processor = DownsamplingImageProcessor(size: coverImage.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        coverImage.kf.indicatorType = .activity
        coverImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "defaultimg"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
