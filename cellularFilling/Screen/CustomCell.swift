//
//  CustomCell.swift
//  cellularFilling
//
//  Created by Анастасия on 14.05.2024.
//

import UIKit

private enum Metrics {
    static let cornerRadius = 12.0
    static let verticalSpacing = 5.0
    static let horizontalSpacing = 20.0
    static let imageSize = 50.0
}

final class CustomCell: UITableViewCell {
    
    //MARK: -> Properties
    static var reuseIdentifier: String {"\(Self.self)"}
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.titleFont
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.descriptionFont
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.textColor = .black
        return label
    }()
    
    private let smileyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.titleFont
        label.textAlignment = .center
        return label
    }()

    private let iconeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Metrics.cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = Metrics.verticalSpacing
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(descriptionLabel)
        return stack
    }()

    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = Metrics.horizontalSpacing
        stack.addArrangedSubview(iconeImageView)
        stack.addArrangedSubview(verticalStack)
        return stack
    }()

    //MARK: -> init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }

    //MARK: -> Functions
    
    override func prepareForReuse() {
        titleLabel.text = ""
        descriptionLabel.text = ""
        smileyLabel.text = ""
        iconeImageView.image = nil
    }
    
    private func setupViews() {
        backgroundColor = .white
        contentView.addSubview(horizontalStack)
        contentView.addSubview(smileyLabel)
        let margins = contentView.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: margins.topAnchor),
            horizontalStack.leadingAnchor.constraint(
                                            equalTo: margins.leadingAnchor,
                                            constant: Constants.Constraints.offset16
                                            ),
            horizontalStack.trailingAnchor.constraint(
                                            equalTo: margins.trailingAnchor,
                                            constant: Constants.Constraints.inset16
                                            ),
            horizontalStack.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            iconeImageView.heightAnchor.constraint(equalToConstant: Metrics.imageSize),
            iconeImageView.widthAnchor.constraint(equalToConstant: Metrics.imageSize),
            
            smileyLabel.centerXAnchor.constraint(equalTo:
                                                iconeImageView.centerXAnchor),
            smileyLabel.centerYAnchor.constraint(equalTo:
                                                iconeImageView.centerYAnchor)
        ])
    }
    
    func configure(model: CellModel) {
        iconeImageView.image = UIImage(named: model.iconName)
        descriptionLabel.text = model.description
        titleLabel.text = model.name
        smileyLabel.text = "\(model.smileyUniCode)"
    }
}

