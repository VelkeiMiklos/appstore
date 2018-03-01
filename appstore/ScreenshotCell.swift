//
//  ScreenshotCell.swift
//  appstore
//
//  Created by Velkei Miklós on 2018. 03. 01..
//  Copyright © 2018. NeonatCore. All rights reserved.
//

import UIKit

class ScreenshotCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var app: App?{
        didSet{
            collectionView.reloadData()
        }
    }
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    private let cellId = "cellId"
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        backgroundColor = .blue
        addSubview(collectionView)
        
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("H:|-14-[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:|[v0][v1(1)]|", views: collectionView, dividerLineView)
        collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotImageCell
        if let image = app?.screenshots?[indexPath.item]
        {
            cell.imageView.image = UIImage(named: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count =  app?.screenshots?.count{
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 200, height: frame.height)
    }
}
private class ScreenshotImageCell:BaseCell
{
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        layer.masksToBounds = true
        addSubview(imageView)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0]|", views: imageView)
        
    }
}
