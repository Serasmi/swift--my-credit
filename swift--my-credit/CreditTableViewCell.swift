//
//  CreditTableViewCell.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 31.05.2021.
//

import UIKit

class CreditTableViewCell: UITableViewCell {
    
    static let identifier = "CreditTableViewCell"
    static let height: CGFloat = 60
    static let padding: CGFloat = 16
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let paymentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let firstLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let lastLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let lineHeight: CGFloat = CreditTableViewCell.height / 3
        let padding: CGFloat = CreditTableViewCell.padding
        let width = contentView.frame.size.width - padding * 2
        
        verticalStackView.frame = contentView.bounds
        firstLineStackView.frame = CGRect(x: padding, y: padding / 2, width: width, height: lineHeight)
        titleLabel.frame = CGRect(x: padding, y: lineHeight + padding / 2, width: width, height: lineHeight)
        lastLineStackView.frame = CGRect(x: padding, y: lineHeight * 2 + padding / 2, width: width, height: lineHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        amountLabel.text = nil
        rateLabel.text = nil
        titleLabel.text = nil
        paymentLabel.text = nil
        rateLabel.text = nil
    }
    
    private func initSubviews() {
        firstLineStackView.addArrangedSubview(amountLabel)
        firstLineStackView.addArrangedSubview(rateLabel)
        
        lastLineStackView.addArrangedSubview(paymentLabel)
        lastLineStackView.addArrangedSubview(durationLabel)
        
        verticalStackView.addSubview(firstLineStackView)
        verticalStackView.addSubview(titleLabel)
        verticalStackView.addSubview(lastLineStackView)
        
        contentView.addSubview(verticalStackView)
    }
    
    func configure(with creditItem: CreditItem) {
        amountLabel.text = "\(creditItem.amount) \(creditItem.currency ?? Constants.defaultCurrency)"
        rateLabel.text = "\(creditItem.rate)%"
        titleLabel.text = creditItem.title
        paymentLabel.text = "\(creditItem.payment) \(creditItem.currency ?? Constants.defaultCurrency)/month"
        durationLabel.text = "\(creditItem.duration)y"
    }

}
