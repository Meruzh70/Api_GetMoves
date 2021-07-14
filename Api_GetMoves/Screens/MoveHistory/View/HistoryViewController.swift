//
//  HistoryViewController.swift
//  Api_GetMoves
//
//  Created by Meruzhan Avetisyan on 12.07.21.
//

import UIKit

class HistoryViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var myGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var dowButton: UIButton!
    @IBOutlet weak var retingImage: UIImageView!
    @IBOutlet weak var miniImage: UIImageView!
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmOverview: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteLbl: UILabel!
    @IBOutlet weak var lenguageLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var popularityLbl: UILabel!
    
    var selectid: MoveResalut?
    var bottomImage: UIImage?
    var topImage = UIImage(named: "Instagram")
       
    override func viewDidLoad() {
        super.viewDidLoad()

        configureImages()
        getMoveHistory()
        configureGesture()
        drawImagesAndText()

        
    }
    
    func getMoveHistory() {
        
        filmImage.image = UIImage(data: try! Data(contentsOf: URL(string: Base_IMAGE_URL.prod.rawValue + selectid!.backdrop_path)!))
        filmTitle.text = selectid?.original_title
        filmOverview.text = selectid?.overview
        miniImage.image = UIImage(data: try! Data(contentsOf: URL(string: Base_IMAGE_URL.prod.rawValue + selectid!.poster_path)!))
        dateLabel.text = selectid?.release_date
        voteLbl.text = "\(selectid!.vote_average)"
        popularityLbl.text = "\(selectid!.popularity)"
        lenguageLbl.text = selectid!.original_language
        viewsLbl.text = "\(selectid!.vote_count)"
        filmImage.image = getMixedImg(image1: filmImage.image!, image2: topImage!)
        
    }
    func configureImages() {
        
        miniImage.layer.cornerRadius = 10
        miniImage.contentMode = .scaleAspectFill
        miniImage.layer.masksToBounds = true
        filmImage.contentMode = .scaleAspectFill
        filmImage.layer.masksToBounds = true
        viewStayl()
    }
    
    func viewStayl() {
        
        dowButton.layer.cornerRadius = 12
        playButton.layer.cornerRadius = 12
    }
    
    func getMixedImg(image1: UIImage, image2: UIImage) -> UIImage {

            let size = CGSize(width: filmImage.frame.size.width, height: filmImage.frame.size.height)

            UIGraphicsBeginImageContext(size)

        image1.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width + 20, height: filmImage.frame.height))
        image2.draw(in: CGRect(x: filmImage.frame.maxX - 70, y: filmImage.frame.maxY - 50, width: 40, height: 40))
            
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return finalImage!
        }
    func drawImagesAndText() {
        // 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: filmImage.frame.width, height: filmImage.frame.height))

        let img = renderer.image { ctx in
            // 2
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            // 3
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18),
                .paragraphStyle: paragraphStyle
            ]
            
            // 4
            let string = "Instagram"
            let attributedString = NSAttributedString(string: string, attributes: attrs)

            // 5
            let mouse = filmImage.image
            mouse?.draw(at: CGPoint(x: 0, y: 0))
            
            attributedString.draw(with: CGRect(x: filmImage.frame.maxX - 170, y: filmImage.frame.maxY - 40, width: 100, height: 20), options: .usesLineFragmentOrigin, context: nil)

        }

        filmImage.image = img
    }

    
    func configureGesture() {
        let screenEdgePanGestureLeft = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(self.didPanningScreenLeft(_:)))
        screenEdgePanGestureLeft.edges = .left
        screenEdgePanGestureLeft.delegate = self
        self.view.addGestureRecognizer(screenEdgePanGestureLeft)
    }
    
  
    @IBAction func backAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
   
    
    @objc func didPanningScreenLeft(_ recognizer: UIScreenEdgePanGestureRecognizer)  {
        print("Left edge penning")
        self.dismiss(animated: true, completion: nil)
    }
    
}



