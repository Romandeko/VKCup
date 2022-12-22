//
//  HobbyCell.swift
//  VK CUP
//
//  Created by Роман Денисенко on 5.12.22.
//

import UIKit

class HobbyCell: UICollectionViewCell {
    
    //MARK: - Static Properties
    static let identifier = "HobbyCell"
    
    //MARK: - IBOutlets
    @IBOutlet weak var markImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var hobbyLabel: UILabel!
    
    //MARK: - Override Properties
    override func awakeFromNib() {
        super.awakeFromNib()
        viewsSetup()
    }
    
    //MARK: - Private Methods
    private func viewsSetup(){
        mainImageView.makeBlur()
        borderView.layer.borderColor = UIColor.white.cgColor
        mainImageView.layer.cornerRadius = mainImageView.frame.height / 4
        borderView.layer.cornerRadius = borderView.frame.height / 4
        markImageView.layer.cornerRadius = markImageView.frame.height / 4
    }
    
    //MARK: - Public Methods
    public func configure(withImage image : UIImage,withtext text : String){
        mainImageView.image = image
        hobbyLabel.text = text
    }
    
    public func isSelected(){
        borderView.layer.borderWidth = 3
        markImageView.isHidden.toggle()
    }
       
    public func isNotSelected(){
        borderView.layer.borderWidth = 0
        markImageView.isHidden.toggle()
    }
    
    //MARK: - Static Methods
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
}

