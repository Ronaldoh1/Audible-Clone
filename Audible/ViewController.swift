//
//  ViewController.swift
//  Audible
//
//  Created by Ronald Hernandez on 1/8/17.
//  Copyright © 2017 Ronaldoh1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellID = "cellID"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        return cv
    }()

    let pages: [Page] = {

        let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to people in your life.", imageName: "page1")
        let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this Book\"", imageName: "page2")
        let thirdPage = Page(title: "Send from the palyer", message: "Tap the More menu in the upper corner. Choose \"Send this Book\"", imageName: "page3")

        return [firstPage, secondPage, thirdPage]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register cell
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: cellID)

        view.addSubview(collectionView)
        collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }


}

extension ViewController : UICollectionViewDelegate {



}

// MARK: UICollectionView Delegate

extension ViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCollectionViewCell
        let page = pages[indexPath.item]
        cell.page = page

        return cell
    }

}

// MARK: UICollectionViewDelegateFlowLayout


extension ViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width, height: view.frame.height)
    }

}

