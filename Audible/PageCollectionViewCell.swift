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
        iv.clipsToBounds = true
        return iv
    }()

    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Text"
        tv.isEditable = false
        tv.contentInset = UIEdgeInsetsMake(24, 0, 0, 0)
        return tv
    }()

    let lineSeparator: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor(white: 0.9, alpha: 1)
        return view
    }()

    var page: Page? {
        didSet {
            guard let page = page else {
                return
            }

            imageView.image = UIImage(named: page.imageName)

            let color = UIColor(white: 0.2, alpha: 1)
            let attributedTitle = NSAttributedString(string: page.title, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName : color])
            let attributedBody = NSAttributedString(string: "\n\n\(page.message)", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName : color])

            let attributedText: NSMutableAttributedString = NSMutableAttributedString()

            attributedText.append(attributedTitle)
            attributedText.append(attributedBody)

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let length = attributedText.string.characters.count
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparator)

        imageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        textView.anchorWithConstantsToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        lineSeparator.anchorToTop(top: nil, left: leftAnchor, bottom: textView.bottomAnchor, right: rightAnchor)
        lineSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
}
