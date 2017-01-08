//
//  PageCollectionViewCell.swift
//  Audible
//
//  Created by Ronald Hernandez on 1/8/17.
//  Copyright © 2017 Ronaldoh1. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "page1")
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpViews() {
        addSubview(imageView)
        imageView.anchorToTop(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
}
