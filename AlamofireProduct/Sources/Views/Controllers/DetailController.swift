//
//  DetailController.swift
//  AlamofireProduct
//
//  Created by Admin on 01.03.2022.
//

import UIKit
import SnapKit
import Kingfisher

private enum Constants {
    static let topOffsets = 15
    static let sideOffsets = 10
    static let textTopOffsets = 36
    static let indicatorTopOffsets = 244
    static let imageTopOffsets = 58
}

final class DetailController: UIViewController {

    var viewModel: DetailViewModelType?
    
    func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byClipping
        return label
    }
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false

        return activityIndicator
    }()
    
    private lazy var descriptioName = createLabel()
    private lazy var descriptionType = createLabel()
    private lazy var setLabel = createLabel()
    private lazy var textLabel = createLabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        guard let viewModel = viewModel else { return }

        configure(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupView()
        setupUI()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        [descriptioName, descriptionType, setLabel, textLabel, imageView, activityIndicator].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupUI() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(Constants.imageTopOffsets)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(350)
        }
        
        descriptioName.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constants.topOffsets)
            make.left.equalToSuperview().offset(Constants.sideOffsets)
            make.right.equalToSuperview().offset(-Constants.sideOffsets)
            make.centerX.equalToSuperview()
        }
        
        descriptionType.snp.makeConstraints { make in
            make.top.equalTo(descriptioName.snp.bottom).offset(Constants.topOffsets)
            make.left.equalToSuperview().offset(Constants.sideOffsets)
            make.right.equalToSuperview().offset(-Constants.sideOffsets)
            make.centerX.equalToSuperview()
        }
        
        setLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionType.snp.bottom).offset(Constants.topOffsets)
            make.left.equalToSuperview().offset(Constants.sideOffsets)
            make.right.equalToSuperview().offset(-Constants.sideOffsets)
            make.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(setLabel.snp.bottom).offset(Constants.textTopOffsets)
            make.left.equalToSuperview().offset(Constants.sideOffsets)
            make.right.equalToSuperview().offset(-Constants.sideOffsets)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(Constants.indicatorTopOffsets)
            make.centerX.equalToSuperview()

        }
    }
    
    func configure(viewModel: DetailViewModelType) {
        
        self.descriptioName.text = viewModel.descriptionName
        self.descriptionType.text = viewModel.descriptionType
        self.setLabel.text = viewModel.set
        self.textLabel.text = viewModel.text
       
        DispatchQueue.main.async {
            guard let imageUrl = URL(string: viewModel.image), let data = try? Data(contentsOf: imageUrl) else { return }
            self.imageView.image = UIImage(data: data)
            self.activityIndicator.stopAnimating()
        
        }
    }
}

