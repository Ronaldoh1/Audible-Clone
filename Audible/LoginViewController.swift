//
//  LoginViewController.swift
//  Audible
//
//  Created by Ronald Hernandez on 1/8/17.
//  Copyright © 2017 Ronaldoh1. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    fileprivate let cellID = "cellID"
    fileprivate let loginCellID = "loginCellID"

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

    lazy var pageController: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()

    lazy var skipButon: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(skipPage), for: .touchUpInside)
        return button
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()

    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        setUpViews()
        observeKeyboardNotification()
    }

    //Handle Rotation for iPhone
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        collectionView.collectionViewLayout.invalidateLayout()

        let indexPath = IndexPath(item: pageController.currentPage, section: 0)

        //Scroll to indexPath after the rotation is going
        DispatchQueue.main.sync {
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }

        collectionView.reloadData()

    }

    // MARK: Helper Methods

    @objc fileprivate func nextPage() {
        if pageController.currentPage == pages.count {
            return
        }

        if pageController.currentPage == pages.count - 1 {
            moveViewsOffScreen()
        }

        let indexPath = IndexPath(item: pageController.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageController.currentPage += 1
    }

    @objc fileprivate func skipPage() {
        pageController.currentPage = pages.count - 1 // go one before the last page.
        nextPage() // go to the next page (the last page). we get to also animate items off the screen.
    }

    fileprivate func setUpViews() {
        view.addSubview(collectionView)
        view.addSubview(pageController)
        view.addSubview(skipButon)
        view.addSubview(nextButton)

        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        pageControlBottomAnchor = pageController.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)[1]

        skipButtonTopAnchor = skipButon.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        nextButtonTopAnchor = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50).first
    }

    fileprivate func observeKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHidden), name: .UIKeyboardWillHide, object: nil)
    }

    @objc fileprivate func handleKeyboardHidden() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

    @objc fileprivate func handleKeyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

    fileprivate func registerCells() {
        collectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: loginCellID)
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }

    fileprivate func moveViewsOffScreen() {
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant =  -40
        nextButtonTopAnchor?.constant = -40
    }

    fileprivate func putViewsBackToScreen() {
        pageControlBottomAnchor?.constant = 0
        skipButtonTopAnchor?.constant = 16
        nextButtonTopAnchor?.constant = 16
    }

    //dismiss keyboard when you scroll

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // use pointee to determine which page you're on.
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageController.currentPage = pageNumber

        //we are on the last page
        if pageNumber == pages.count {
            moveViewsOffScreen()

        } else {
            putViewsBackToScreen()
        }

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}

// MARK: LoginControllerDelegate

extension LoginViewController : LoginControllerDelegate {

    func finishLogginIn() {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController as?  MainNavigationController else {
            return
        }

        rootViewController.viewControllers = [HomeViewController()]
        UserDefaults.standard.setIsLoggedIn(value: true)

        dismiss(animated: true, completion: nil)
    }

}

// MARK: UICollectionView Delegate

extension LoginViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return pages.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellID, for: indexPath) as! LoginCollectionViewCell
            loginCell.loginControllerDelegate = self
            return loginCell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCollectionViewCell
        let page = pages[indexPath.item]
        cell.page = page

        return cell
    }

}

// MARK: UICollectionViewDelegateFlowLayout


extension LoginViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
