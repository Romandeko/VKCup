//
//  ViewController.swift
//  VK CUP
//
//  Created by Роман Денисенко on 5.12.22.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Private Properties
    private var hobbiesNames : [String] = ["Аниме","Спорт","Еда","Машины","Фильмы","Юмор","Мода","Маникюр","Музыка","Книги","Животные","Игры","Наука","Космос","Природа","Туризм","Искусство","Подарки"]
    private var hobbiesImages : [UIImage] = []
    private var spacingBetweenCells : CGFloat = 5
    private var numberOfItemsPerRow : CGFloat = 3
    private var selectedCells = 0
    private var isButtonHidden = true
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    //MARK: - Override Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        basicSetup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        continueButton.setTitle(NSLocalizedString("Continue_button", comment: ""), for: .normal)
    }
    
    //MARK: - Private Methods
    private func basicSetup(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HobbyCell.nib(), forCellWithReuseIdentifier: HobbyCell.identifier)
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
        for index in 0...hobbiesNames.count - 1{
            guard let image = UIImage(named:hobbiesNames[index]) else { return}
            hobbiesImages.append(image)
        }
    }
}

extension MainViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hobbiesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HobbyCell.identifier, for: indexPath) as?  HobbyCell else { return UICollectionViewCell() }
        
        cell.configure(withImage: hobbiesImages[index], withtext: NSLocalizedString(hobbiesNames[index], comment: ""))
        
        return cell
    }
}

extension MainViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HobbyCell
        else { return }
        
        if cell.markImageView.isHidden{
            cell.isSelected()
            selectedCells += 1
        } else {
            cell.isNotSelected()
            selectedCells -= 1
        }
        
        if isButtonHidden {
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6){ [weak self] in
                self?.buttonBottomConstraint.constant = 50
                self?.view.layoutSubviews()
                self?.isButtonHidden = false
                return
            }
        }
        
        if selectedCells == 0{
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6){ [weak self] in
                self?.buttonBottomConstraint.constant = -150
                self?.view.layoutSubviews()
                self?.isButtonHidden = true
            }
        }
    }
}

extension MainViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalHorizontalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells
        let width = (collectionView.bounds.width - totalHorizontalSpacing) / numberOfItemsPerRow - 1
        return CGSize(width: width, height: width)
    }
}
