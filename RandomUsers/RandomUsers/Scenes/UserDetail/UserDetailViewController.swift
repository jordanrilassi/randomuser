//
//  UserDetailViewController.swift
//  RandomUsers
//
//  Created by Rilassi Jordan.

import UIKit

protocol UserDetailDisplayLogic: AnyObject
{
    func displayUserDetail(viewModel: UserDetail.UserDetailModel.ViewModel)
}

class UserDetailViewController: UIViewController, UserDetailDisplayLogic
{
    var interactor: UserDetailBusinessLogic?
    var router: (NSObjectProtocol & UserDetailRoutingLogic & UserDetailDataPassing)?
    
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
        let interactor = UserDetailInteractor()
        let presenter = UserDetailPresenter()
        let router = UserDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        loadUserDetail()
    }
    
    func setupView() {
        
    }
    
    // MARK: Load User Detail
    
    var mainStackView = UIStackView()
    var userPicture = UIImageView()
    
    
    func loadUserDetail()
    {
        interactor?.getUserDetail()
    }
    
    func displayUserDetail(viewModel: UserDetail.UserDetailModel.ViewModel)
    {
        title = viewModel.userDetailViewModel.fullname
        //nameTextField.text = viewModel.name
    }
}
