//
//  RepositoryCell.swift
//  Github Respository App
//
//  Created by Inam on 28.01.22.
//

import UIKit
import PureLayout
import FontAwesome
import Kingfisher

protocol RepositoryCellDelegate: AnyObject {
    func repositoryCellRepoSectionClicked(_ cell: RepositoryCell)
    func repositoryCellOwnerSectionClicked(_ cell: RepositoryCell)
}

class RepositoryCell: UITableViewCell {
    
    private let repositoryNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    private let repositoryDescLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .darkGray
        view.numberOfLines = 3
        return view
    }()
    
    private let repositoryLanguageLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .darkGray
        return view
    }()
    
    private let starsLabel: UILabel = {
        let view = UILabel()
        view.font = .fontAwesome(ofSize: 15, style: .solid)
        view.textColor = .orange
        return view
    }()
    
    private let forksLabel: UILabel = {
        let view = UILabel()
        view.font = .fontAwesome(ofSize: 15, style: .solid)
        view.textColor = .black
        return view
    }()
    
    private let watchersLabel: UILabel = {
        let view = UILabel()
        view.font = .fontAwesome(ofSize: 15, style: .solid)
        view.textColor = .green
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
    
    var repositoryName: String? = nil {
        didSet {
            repositoryNameLabel.text = repositoryName
        }
    }
    
    var repositoryLanguage: String? = nil {
        didSet {
            repositoryLanguageLabel.text = repositoryLanguage
        }
    }
    
    var repositoryDescription: String? = nil {
        didSet {
            repositoryDescLabel.text = repositoryDescription
        }
    }
    
    var repositoryStarCount: Int64? = nil {
        didSet {
            starsLabel.text = "\(String.fontAwesomeIcon(name: .grinStars)) \(repositoryStarCount ?? 0)"
        }
    }
    
    var repositoryForkCount: Int64? = nil {
        didSet {
            forksLabel.text = "\(String.fontAwesomeIcon(name: .codeBranch)) \(repositoryStarCount ?? 0)"
        }
    }
    
    var repositoryWatcherCount: Int64? = nil {
        didSet {
            watchersLabel.text = "\(String.fontAwesomeIcon(name: .glasses)) \(repositoryStarCount ?? 0)"
        }
    }
    
    var ownerName: String? = nil {
        didSet {
            ownerNameLabel.text = ownerName
        }
    }
    
    var ownerAvatarURLString: String? = nil {
        didSet {
            if let urlString = ownerAvatarURLString {
                let url = URL(string: urlString)
                ownerAvatartImageView.kf.setImage(with: url)
            }
        }
    }
    
    weak var delegate: RepositoryCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Container View
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        contentView.addSubview(containerView)
        containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        
        // Repository Info Views
        let repositoryStatsStackView = UIStackView(arrangedSubviews: [starsLabel,
                                                                      forksLabel,
                                                                      watchersLabel])
        repositoryStatsStackView.axis = .horizontal
        repositoryStatsStackView.distribution = .equalSpacing
        repositoryStatsStackView.spacing = 5
        
        let repositoryStackView = UIStackView(arrangedSubviews: [repositoryNameLabel,
                                                                 repositoryLanguageLabel,
                                                                 repositoryStatsStackView,
                                                                 repositoryDescLabel])
        repositoryStackView.axis = .vertical
        repositoryStackView.distribution = .fillProportionally
        repositoryStackView.spacing = 10
        
        let repositoryContainer = UIView()
        repositoryContainer.backgroundColor = UIColor(hex: 0xF5F5F5)
        repositoryContainer.addSubview(repositoryStackView)
        repositoryStackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        repositoryContainer.isUserInteractionEnabled = true
        repositoryContainer.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                        action: #selector(repositoryTapped)))
        
        // Owner Info Views
        ownerAvatartImageView.layer.cornerRadius = 25
        ownerAvatartImageView.layer.borderColor = UIColor.white.cgColor
        ownerAvatartImageView.layer.borderWidth = 1
        ownerAvatartImageView.autoSetDimensions(to: CGSize(width: 50, height: 50))
        
        let ownerStackView = UIStackView(arrangedSubviews: [ownerAvatartImageView,
                                                            ownerNameLabel])
        ownerStackView.axis = .horizontal
        ownerStackView.spacing = 15
        
        let ownerContainer = UIView()
        ownerContainer.backgroundColor = UIColor(hex: 0x36454F)
        ownerContainer.addSubview(ownerStackView)
        ownerStackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        ownerContainer.isUserInteractionEnabled = true
        ownerContainer.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(ownerTapped)))
        
        // Final setup
        let overallStackView = UIStackView(arrangedSubviews: [repositoryContainer,
                                                              ownerContainer])
        overallStackView.axis = .vertical
        overallStackView.distribution = .fillProportionally
        overallStackView.spacing = 4
        containerView.addSubview(overallStackView)
        overallStackView.autoPinEdgesToSuperviewEdges()
        
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        repositoryName = nil
        repositoryLanguage = nil
        repositoryDescription = nil
        repositoryStarCount = nil
        repositoryForkCount = nil
        repositoryWatcherCount = nil
        ownerName = nil
        ownerAvatartImageView.image = nil
    }
    
    @objc
    private func repositoryTapped() {
        delegate?.repositoryCellRepoSectionClicked(self)
    }
    
    @objc
    private func ownerTapped() {
        delegate?.repositoryCellOwnerSectionClicked(self)
    }
}
