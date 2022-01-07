//
//  HomeViewController.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

protocol HomeDisplayLogic: AnyObject
{
    func displayUsers(viewModel: Home.Users.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic
{
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = HomeInteractor(userService: UserAPIService())
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupCollectionView()
        loadFirstUsers()
    }
    
    private var collectionView: UICollectionView?
    private var users: [UserViewModel] = []
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 60)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(HomeUserCell.self, forCellWithReuseIdentifier: CollectionViewCells.homeUserCell.rawValue)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    private func loadFirstUsers()
    {
        interactor?.loadUserBatch()
    }
    
    func displayUsers(viewModel: Home.Users.ViewModel)
    {
        users = viewModel.usersViewModel
        collectionView?.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let homeUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.homeUserCell.rawValue, for: indexPath) as? HomeUserCell else {
            return UICollectionViewCell()
        }
        let userViewModel = users[indexPath.row]
        homeUserCell.userViewModel = userViewModel
        return homeUserCell
    }
}
