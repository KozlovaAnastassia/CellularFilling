//
//  ViewController.swift
//  cellularFilling
//
//  Created by Анастасия on 14.05.2024.
//
import UIKit

private enum Metrics {
    static let cellHeight = 72.0
    static let bottomInset = 50.0
    static let buttonHeight = 36.0
    static let cellCornerRadius = 10.0
    static let headerLabelY = -20.0
    static let headerLabelHeight = 30.0
}

final class ViewController: UIViewController {
    
//MARK: -> Properties
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Title.buttonTitle.uppercased(), for: .normal)
        button.backgroundColor = Constants.Colors.button
        button.titleLabel?.font = Constants.Font.titleFont
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addAction(UIAction { _ in
            self.viewModel.buttonTapped()
            self.tableView.reloadData()
        }, for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private let viewModel: IViewModel
    
    //MARK: -> init
    
    init(viewModel: IViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpTableView()
    }
    
//MARK: -> Functions
   private func setUpViews() {
        view.backgroundColor = .black
        view.addSubview(tableView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, 
                                               constant: Constants.Constraints.offset16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: Constants.Constraints.inset16),
        
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, 
                                           constant: Constants.Constraints.inset16),
            button.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,
                                          constant: Constants.Constraints.inset16),
            button.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    private func setUpTableView() {
        tableView.contentInset = UIEdgeInsets(
                                        top: 0,
                                        left: 0,
                                        bottom: Metrics.bottomInset,
                                        right: 0
                                 )
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray
    }
}
//MARK: -> Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseIdentifier,
                                                 for: indexPath
                                                    )as? CustomCell
        cell?.configure(model: viewModel.getDataForCell(indexPath: indexPath))
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel()
        headerLabel.textColor = .white
        headerLabel.text = Constants.Title.headerTitle
        headerLabel.textAlignment = .center
        headerLabel.font = Constants.Font.headerFont
        headerLabel.frame = CGRect(
                                x: 0,
                                y: Metrics.headerLabelY,
                                width: tableView.frame.width,
                                height: Metrics.headerLabelHeight
                            )
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Metrics.cellHeight
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.cornerRadius = Metrics.cellCornerRadius
        cell.contentView.layer.masksToBounds = true
    }
}
