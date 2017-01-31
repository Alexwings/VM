//
//  HomeController.swift
//  VM
//
//  Created by Xinyuan Wang on 1/22/17.
//  Copyright © 2017 RJT. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class HomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //MARK: properties

    let imageView : MusicPicView = {
        let vi = MusicPicView(frame: .zero)
        vi.translatesAutoresizingMaskIntoConstraints = false
        return vi
    }()
    
    lazy var videoButton : UIButton = { return self.button(imageName: "videoIcon")}()
    
    lazy var musicButton : UIButton = {return self.button(imageName: "musicIcon")}()
    
    lazy var localButton : UIButton = {return self.button(imageName: "localIcon")}()
    
    let btnStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    //test images
    let testImages = ["tylerSwift", "brunoMars", "justinTimberlake", "pharrellWilliams"]
   
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        imageView.imageCollection.dataSource = self
        imageView.imageCollection.delegate = self
        musicButton.addTarget(self, action: #selector(self.buttonClicked(_:)), for: .touchUpInside)
        videoButton.addTarget(self, action: #selector(self.buttonClicked(_:)), for: .touchUpInside)
        localButton.addTarget(self, action: #selector(self.buttonClicked(_:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Event Methods
    func menuButtonClicked() {
        if let menuControl = slideMenuController() {
            menuControl.openLeft()
        }
    }
    func buttonClicked(_ sender: UIButton) {
        switch sender {
        case musicButton:
            performSegue(withIdentifier: "toAlbumSegue", sender: sender)
            break
        case videoButton:
            //TODO: jump to video
            print("video")
            break
        case localButton:
            //TODO: jump to local
            print("downloaded")
            break
        default:
            break
        }
    }
    //MARK: - Private Methods
    
    private func button(imageName:String) -> UIButton {
        let btn = UIButton(type: .custom)
        let image = UIImage(named:imageName)?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.clipsToBounds = true
        btn.tintColor = btn.isHighlighted ? UIColor.lightGray : UIColor.white
        btn.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addConstraint(NSLayoutConstraint(item: btn, attribute: .height, relatedBy: .equal, toItem: btn, attribute: .width, multiplier: 1, constant: 0))
        return btn
    }
    
    private func setupViews() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = "HOME"
        addLeftBarButtonWithImage((UIImage(named: "Menu")?.withRenderingMode(.alwaysTemplate))!)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
//        let searchImg = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
//        let searchButton = UIBarButtonItem(image: , style: <#T##UIBarButtonItemStyle#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        
        
        view.addSubview(imageView)
        btnStack.addArrangedSubview(musicButton)
        btnStack.addArrangedSubview(videoButton)
        btnStack.addArrangedSubview(localButton)
        view.addSubview(btnStack)
        
        
        let imgHeight = view.bounds.size.width * 9 / 16
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        view.addConstraintsWithFormat(format: "V:|[v0(\(imgHeight))]-(>=50)-[v1(50)]", views: imageView, btnStack)
        
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: btnStack)
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageView.pageIndicator.numberOfPages = testImages.count
        imageView.pageIndicator.size(forNumberOfPages: testImages.count)
        return testImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageView.cellId, for: indexPath)
        let imgView = UIImageView(frame: cell.contentView.frame)
        imgView.image = UIImage(named: testImages[indexPath.item])
        imgView.contentMode = .scaleAspectFill
        cell.backgroundView = imgView
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageView.pageIndicator.currentPage = indexPath.item
        imageView.pageIndicator.updateCurrentPageDisplay()
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imgHeight = view.bounds.size.width * 9 / 16
        return CGSize(width: view.bounds.size.width, height: imgHeight)
    }
}
