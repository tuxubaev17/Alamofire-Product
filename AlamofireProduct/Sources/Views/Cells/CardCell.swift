//
//  CardCell.swift
//  AlamofireProduct
//
//  Created by Admin on 28.02.2022.
//

import UIKit
import SnapKit

class CardCell: UITableViewCell {
    static let identifier = "CardCell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.lineBreakMode = .byClipping
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupHierarchy() {
        [nameLabel, typeLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupView() {
        contentView.clipsToBounds = true
    }
    
    private func setupLayout() {
        nameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.right.equalToSuperview().offset(-10)
        }
    }
}
