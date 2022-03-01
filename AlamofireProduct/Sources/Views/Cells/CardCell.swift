//
//  CardCell.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import UIKit
import SnapKit

private enum Constants {
    static let numberOfLines = 1
    static let sideOffsets = 10
}

final class CardCell: UITableViewCell {
    
    static let identifier = "CardCell"
    
    func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = Constants.numberOfLines
        label.textAlignment = .left
        label.lineBreakMode = .byClipping
        return label
    }
    
    lazy var nameLabel = createLabel()
    lazy var rareLabel = createLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupHierarchy() {
        [nameLabel, rareLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupView() {
        contentView.clipsToBounds = true
    }
    
    private func setupLayout() {
        nameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.sideOffsets)
            $0.top.equalToSuperview().offset(Constants.sideOffsets)
            $0.bottom.equalToSuperview().offset(-Constants.sideOffsets)
        }
        
        rareLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.sideOffsets)
            $0.bottom.equalToSuperview().offset(-Constants.sideOffsets)
            $0.right.equalToSuperview().offset(-Constants.sideOffsets)
        }
    }
    
    var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            nameLabel.text = viewModel.name
            rareLabel.text = viewModel.rarity
        }
    }
}
