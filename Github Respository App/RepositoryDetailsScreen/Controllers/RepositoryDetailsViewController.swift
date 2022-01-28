//
//  RepositoryDetailsViewController.swift
//  Github Respository App
//
//  Created by Inam on 28.01.22.
//

import UIKit
import PureLayout
import FontAwesome
import SafariServices

class RepositoryDetailsViewController: UIViewController {
    
    private let repositoryNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 25)
        view.textColor = .orange
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private let repositoryLanguageLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .darkGray
        return view
    }()
    
    private let ownerCaption: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .light)
        view.textColor = .lightGray
        view.text = "Owned By"
        return view
    }()
    
    private let ownerAvatartImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let ownerNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.textColor = .white
        return view
    }()
    
    private let repositoryDescLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .darkGray
        view.numberOfLines = 0
        return view
    }()
    
    private let statsCaption: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .light)
        view.textColor = .lightGray
        view.text = "Statistics"
        return view
    }()
    
    private let descriptionCaption: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .light)
        view.textColor = .lightGray
        view.text = "Description"
        return view
    }()
    
    private let licenseCaption: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .light)
        view.textColor = .lightGray
        view.text = "License"
        return view
    }()
    
    private let licenseNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.textColor = .black
        return view
    }()
    
    private lazy var openExternallyButton: UIButton = {
        var tinted = UIButton.Configuration.tinted()
        tinted.title = "Open Externally"
        tinted.buttonSize = .large
        tinted.baseBackgroundColor = .systemCyan
        tinted.baseForegroundColor = .white
        let view = UIButton(configuration: tinted, primaryAction: UIAction() { [weak self] _ in
            if let externalLink = self?.externalLink, let url = URL(string: externalLink) {
                let safariController = SFSafariViewController(url: url)
                self?.present(safariController, animated: true, completion: nil)
            }
        })
        return view
    }()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let repository: RepositoryResponse
    
    private var repositoryName: String? = nil {
        didSet {
            repositoryNameLabel.text = repositoryName
        }
    }
    
    private var repositoryLanguage: String? = nil {
        didSet {
            repositoryLanguageLabel.text = repositoryLanguage
        }
    }
    
    private var repositoryDescription: String? = nil {
        didSet {
            repositoryDescLabel.text = repositoryDescription
        }
    }
    
    private var ownerName: String? = nil {
        didSet {
            ownerNameLabel.text = ownerName
        }
    }
    
    private var licenseName: String? = nil {
        didSet {
            licenseNameLabel.text = licenseName
        }
    }
    
    private var ownerAvatarURLString: String? = nil {
        didSet {
            if let urlString = ownerAvatarURLString {
                let url = URL(string: urlString)
                ownerAvatartImageView.kf.setImage(with: url)
            }
        }
    }
    
    private var externalLink: String?
    
    init(repository: RepositoryResponse) {
        self.repository = repository
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Repository Detail"
        view.backgroundColor = .white
        contentView.backgroundColor = .white
        
        setupFields()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewEdges()
        
        scrollView.addSubview(contentView)
        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoAlignAxis(toSuperviewAxis: .vertical)
        contentView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        contentView.addSubview(repositoryNameLabel)
        repositoryNameLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                                                         excludingEdge: .bottom)
        
        contentView.addSubview(ownerCaption)
        ownerCaption.autoPinEdge(.top, to: .bottom, of: repositoryNameLabel, withOffset: 20)
        ownerCaption.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        ownerCaption.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        ownerAvatartImageView.layer.cornerRadius = 25
        ownerAvatartImageView.layer.borderColor = UIColor.white.cgColor
        ownerAvatartImageView.layer.borderWidth = 1
        ownerAvatartImageView.autoSetDimensions(to: CGSize(width: 50, height: 50))
        
        let ownerStackView = UIStackView(arrangedSubviews: [ownerAvatartImageView,
                                                            ownerNameLabel])
        ownerStackView.axis = .horizontal
        ownerStackView.spacing = 15
        
        let ownerContainer = UIView()
        ownerContainer.clipsToBounds = true
        ownerContainer.layer.cornerRadius = 5
        ownerContainer.backgroundColor = UIColor(hex: 0x36454F)
        ownerContainer.addSubview(ownerStackView)
        ownerStackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        contentView.addSubview(ownerContainer)
        ownerContainer.autoPinEdge(.top, to: .bottom, of: ownerCaption, withOffset: 10)
        ownerContainer.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        ownerContainer.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        ownerContainer.isUserInteractionEnabled = true
        ownerContainer.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(ownerTapped)))
        
        contentView.addSubview(licenseCaption)
        licenseCaption.autoPinEdge(.top, to: .bottom, of: ownerContainer, withOffset: 20)
        licenseCaption.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        licenseCaption.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        contentView.addSubview(licenseNameLabel)
        licenseNameLabel.autoPinEdge(.top, to: .bottom, of: licenseCaption, withOffset: 10)
        licenseNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        licenseNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        let starsLabel = UILabel()
        starsLabel.text = "\(String.fontAwesomeIcon(name: .grinStars)) \(repository.starsCount)"
        let forksLabel = UILabel()
        forksLabel.text = "\(String.fontAwesomeIcon(name: .codeBranch)) \(repository.forksCount)"
        let watchersLabel = UILabel()
        watchersLabel.text = "\(String.fontAwesomeIcon(name: .glasses)) \(repository.watchersCount)"
        let issuesLabel = UILabel()
        issuesLabel.text = "\(String.fontAwesomeIcon(name: .boxOpen)) \(repository.issuesCount)"
        
        let statsArr = [starsLabel, forksLabel, watchersLabel, issuesLabel]
        statsArr.forEach {
            $0.font = .fontAwesome(ofSize: 20, style: .solid)
            $0.textColor = .darkGray
        }
        
        contentView.addSubview(statsCaption)
        statsCaption.autoPinEdge(.top, to: .bottom, of: licenseNameLabel, withOffset: 20)
        statsCaption.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        statsCaption.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        let statsStackView = UIStackView(arrangedSubviews: statsArr)
        statsStackView.axis = .vertical
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 5
        contentView.addSubview(statsStackView)
        statsStackView.autoPinEdge(.top, to: .bottom, of: statsCaption, withOffset: 20)
        statsStackView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        statsStackView.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        contentView.addSubview(descriptionCaption)
        descriptionCaption.autoPinEdge(.top, to: .bottom, of: statsStackView, withOffset: 20)
        descriptionCaption.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        descriptionCaption.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        contentView.addSubview(repositoryDescLabel)
        repositoryDescLabel.autoPinEdge(.top, to: .bottom, of: descriptionCaption, withOffset: 10)
        repositoryDescLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        repositoryDescLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        contentView.addSubview(openExternallyButton)
        openExternallyButton.autoPinEdge(.top, to: .bottom, of: repositoryDescLabel, withOffset: 30)
        openExternallyButton.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        openExternallyButton.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
    }
    
    private func setupFields() {
        repositoryName = repository.name.capitalized
        repositoryLanguage = repository.language
        repositoryDescription = repository.description
        licenseName = repository.license.name.capitalized
        externalLink = repository.url
        ownerName = repository.owner.login
        ownerAvatarURLString = repository.owner.avatarUrl
    }
    
    @objc
    private func ownerTapped() {
        
    }
}
