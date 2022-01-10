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
        title = "Random Users"
        view.backgroundColor = .white
        
        setupCollectionView()
        loadUserBatch()
    }
    
    private var collectionView: UICollectionView?
    private var isBatchLoading = false
    private var users: [UserViewModel] = []
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 60)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(HomeUserCell.self, forCellWithReuseIdentifier: CollectionViewCells.homeUserCell.rawValue)
        collectionView?.register(ActivityIndicatorCell.self, forCellWithReuseIdentifier: CollectionViewCells.activityIndicatorCell.rawValue)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.alwaysBounceVertical = true
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(reloadAllUsers), for: .valueChanged)
        
        collectionView?.refreshControl = refresher
        collectionView?.refreshControl?.beginRefreshing()
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    private func loadUserBatch()
    {
        isBatchLoading = true
        interactor?.loadUserBatch()
    }
    
    @objc private func reloadAllUsers() {
        isBatchLoading = true
        interactor?.reloadAllUsers()
    }
    
    func displayUsers(viewModel: Home.Users.ViewModel)
    {
        if users.isEmpty || collectionView?.refreshControl?.isRefreshing == true {
            users = viewModel.usersViewModel
            collectionView?.reloadData()
            isBatchLoading = false
            collectionView?.refreshControl?.endRefreshing()
        } else {
            var newIndexPaths: [IndexPath] = []
            for index in 1...viewModel.usersViewModel.count {
                let row = users.count-1 + index
                let indexPath = IndexPath(row: row, section: 0)
                newIndexPaths.append(indexPath)
            }
            users.append(contentsOf: viewModel.usersViewModel)
            
            collectionView?.performBatchUpdates({ [weak self] in
                self?.collectionView?.insertItems(at: newIndexPaths)
            }, completion: { [weak self] _ in
                self?.isBatchLoading = false
            })
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.isEmpty ? 0 : users.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row != users.count else {
            return loadActivityIndicatorCell(collectionView: collectionView, cellForItemAt: indexPath)
        }
        
        return loadHomeUserCell(collectionView: collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == users.count, !isBatchLoading {
            loadUserBatch()
        }
    }
    
    private func loadActivityIndicatorCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ActivityIndicatorCell {
        let activityIndicatorCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.activityIndicatorCell.rawValue, for: indexPath) as? ActivityIndicatorCell ?? ActivityIndicatorCell()
        return activityIndicatorCell
    }
    
    private func loadHomeUserCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> HomeUserCell {
        let homeUserCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.homeUserCell.rawValue, for: indexPath) as? HomeUserCell ?? HomeUserCell()
        let userViewModel = users[indexPath.row]
        homeUserCell.setupView(with: userViewModel)
        return homeUserCell
    }
}
