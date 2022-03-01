//
//  DetailController.swift
//  AlamofireProduct
//
//  Created by Admin on 01.03.2022.
//

import UIKit
import SnapKit

class DetailController: UIViewController {
    
    var viewModel: DetailViewModelType?
    
    lazy var descriptioName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private lazy var descriptionType: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private lazy var setLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let viewModel = viewModel else { return }
        DispatchQueue.main.async {
            self.descriptioName.text = viewModel.descriptionName
            self.descriptionType.text = viewModel.descriptionType
            self.setLabel.text = viewModel.set
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupHierarchy()
        setupUI()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        [descriptioName, descriptionType, setLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupUI() {
        descriptioName.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(58)
            make.centerX.equalToSuperview()
        }
        
        descriptionType.snp.makeConstraints { make in
            make.top.equalTo(descriptioName.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        setLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionType.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
}


