//
//  ProfileViewController.swift
//  LogicControllersDemo
//
//  Created by Mike Gopsill on 14/09/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    private let logicController: ProfileLogicController
    
    private var firstNameLabel = UILabel()
    private var surnameLabel = UILabel()
    private var profileImage = UIImageView()
    private var reloadButton = UIButton()
    
    init(with logicController: ProfileLogicController) {
        self.logicController = logicController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
        
        render(.loading)
        
        logicController.load { [weak self] state in
            self?.render(state)
        }
    }
    
    private func setupViews() {        
        firstNameLabel = UILabel()
        firstNameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        firstNameLabel.textAlignment = .center
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.text = "loading.."
        surnameLabel = UILabel()
        surnameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        surnameLabel.textAlignment = .center
        surnameLabel.translatesAutoresizingMaskIntoConstraints = false
        surnameLabel.text = "loading.."
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFit
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.backgroundColor = .black
        reloadButton.setTitle("Reload", for: .normal)
        reloadButton.addTarget(self, action: #selector(didTapReload), for: .touchUpInside)
        
        view.addSubview(firstNameLabel)
        view.addSubview(surnameLabel)
        view.addSubview(profileImage)
        view.addSubview(reloadButton)
        
        let constraints: [NSLayoutConstraint] = [
            firstNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstNameLabel.heightAnchor.constraint(equalToConstant: 40.0),
            surnameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 10.0),
            surnameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            surnameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            surnameLabel.heightAnchor.constraint(equalToConstant: 40.0),
            profileImage.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 10.0),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 200.0),
            reloadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30.0),
            reloadButton.heightAnchor.constraint(equalToConstant: 50.0),
            reloadButton.widthAnchor.constraint(equalToConstant: 80.0),
            reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func display(_ user: User) {
        firstNameLabel.text = user.firstName
        surnameLabel.text = user.surname
        profileImage.image = user.profileImage
    }
    
    private func display(_ error: Error) {
        firstNameLabel.text = "Whoops"
        surnameLabel.text = "Who are you?"
        profileImage.image = UIImage(named: "error")
    }
    
    @objc private func didTapReload() {
        render(.loading)
        
        logicController.load { [weak self] state in
            self?.render(state)
        }
    }
}

private extension ProfileViewController {
    func render(_ state: ProfileState) {
        switch state {
        case .loading:
            showLoadingSpinner()
        case .presenting(let user):
            removeLoadingSpinner()
            display(user)
        case .failed(let error):
            removeLoadingSpinner()
            display(error)
        }
    }
}

extension UIViewController {
    func showLoadingSpinner() {
        let loadingSpinnerView = LoadingSpinnerView()
        loadingSpinnerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingSpinnerView)
        
        let constraints:[NSLayoutConstraint] = [
            loadingSpinnerView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingSpinnerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingSpinnerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingSpinnerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func removeLoadingSpinner() {
        let loadingSpinner = view.subviews.filter { $0 is LoadingSpinnerView }.first
        if let spinner = loadingSpinner {
            spinner.removeFromSuperview()
        }
    }
}
