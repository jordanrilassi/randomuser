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
        setupView()
        loadUserDetail()
    }
    
    // MARK: Load User Detail
    
    var userDetailViewModel: UserDetailViewModel?
    
    var scrollView = UIScrollView()
    var mainStackView = UIStackView()
    var userPictureStackView = UIStackView()
    var userPicture = UIImageView()
    var userInfoLabel = UILabel()
    var addressLabel = UILabel()
    var addressContentLabel = UILabel()
    var contactMeLabel = UILabel()
    var emailButton = UIButton()
    var phoneButton = UIButton()
    var cellButton = UIButton()
    
    func loadUserDetail()
    {
        interactor?.getUserDetail()
    }
    
    func displayUserDetail(viewModel: UserDetail.UserDetailModel.ViewModel)
    {
        userDetailViewModel = viewModel.userDetailViewModel
        title = viewModel.userDetailViewModel.fullname
        userPicture.load(urlString: viewModel.userDetailViewModel.pictureUrlString) { [weak self] in
            DispatchQueue.main.async {
                self?.userPicture.roundedCorner()
            }
        }
        userInfoLabel.text = viewModel.userDetailViewModel.infoUser
        addressLabel.text = "Adresse :"
        addressLabel.font = .boldSystemFont(ofSize: addressLabel.font.pointSize)
        addressContentLabel.text = viewModel.userDetailViewModel.address
        contactMeLabel.text = "Contact :"
        contactMeLabel.font = .boldSystemFont(ofSize: contactMeLabel.font.pointSize)
        emailButton.setTitle(viewModel.userDetailViewModel.email, for: .normal)
        emailButton.sizeToFit()
        phoneButton.setTitle(viewModel.userDetailViewModel.phone, for: .normal)
        cellButton.setTitle(viewModel.userDetailViewModel.cell, for: .normal)
    }
}

// MARK: Setup UI Methods

extension UserDetailViewController {
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        
        userPictureStackView.axis = .horizontal
        userPictureStackView.alignment = .center
        userPictureStackView.distribution = .equalCentering
        userPictureStackView.addArrangedSubview(UIView())
        userPictureStackView.addArrangedSubview(userPicture)
        userPictureStackView.addArrangedSubview(UIView())

        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        mainStackView.addArrangedSubview(userPictureStackView)
        mainStackView.addArrangedSubview(UIView())
        mainStackView.addArrangedSubview(userInfoLabel)
        mainStackView.addArrangedSubview(UIView())
        mainStackView.addArrangedSubview(addressLabel)
        mainStackView.addArrangedSubview(addressContentLabel)
        mainStackView.addArrangedSubview(UIView())
        mainStackView.addArrangedSubview(contactMeLabel)
        
        let emailStackView = UIStackView()
        emailStackView.axis = .horizontal
        emailStackView.addArrangedSubview(emailButton)
        emailStackView.addArrangedSubview(UIView())
        let phoneStackView = UIStackView()
        phoneStackView.axis = .horizontal
        phoneStackView.addArrangedSubview(phoneButton)
        phoneStackView.addArrangedSubview(UIView())
        let cellStackView = UIStackView()
        cellStackView.axis = .horizontal
        cellStackView.addArrangedSubview(cellButton)
        cellStackView.addArrangedSubview(UIView())
        
        let contactStackView = UIStackView()
        contactStackView.axis = .vertical
        contactStackView.addArrangedSubview(emailStackView)
        contactStackView.addArrangedSubview(phoneStackView)
        contactStackView.addArrangedSubview(cellStackView)
        mainStackView.addArrangedSubview(contactStackView)
        mainStackView.addArrangedSubview(UIView())
        
        userPicture.contentMode = .scaleAspectFit
        userPicture.center = mainStackView.center
        userPicture.image = UIImage(systemName: "person.circle")
        userPicture.tintColor = .gray
        
        userInfoLabel.numberOfLines = 0
        addressContentLabel.numberOfLines = 0
        applyConstraints()
        
        emailButton.setTitleColor(.blue, for: .normal)
        phoneButton.setTitleColor(.blue, for: .normal)
        cellButton.setTitleColor(.blue, for: .normal)
        
        emailButton.addTarget(self, action: #selector(emailButtonTouched), for: .touchUpInside)
        phoneButton.addTarget(self, action: #selector(phoneButtonTouched), for: .touchUpInside)
        cellButton.addTarget(self, action: #selector(cellButtonTouched), for: .touchUpInside)
    }
    
    private func applyConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.alwaysBounceVertical = true
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 20).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20).isActive = true
        
        userPicture.widthAnchor.constraint(equalToConstant: 150).isActive = true
        userPicture.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}

// MARK: Buttons Methods

extension UserDetailViewController {
    @objc func emailButtonTouched() {
        guard let email = userDetailViewModel?.email else { return }
        guard let url = URL(string: "mailto:\(email)") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func phoneButtonTouched() {
        guard let phone = userDetailViewModel?.phone else { return }
        guard let number = URL(string: "tel://" + phone) else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func cellButtonTouched() {
        guard let cell = userDetailViewModel?.cell else { return }
        guard let number = URL(string: "tel://" + cell) else { return }
        UIApplication.shared.open(number)
    }
}
