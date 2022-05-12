//
//  GithubUserListTableViewCell.swift
//  SearchingUserGithub
//
//  Created by CoffeeLatte on 12/05/22.
//

import UIKit

class GithubUserListTableViewCell: UITableViewCell, ReusableViewCell {
    
    // MARK: - Private Variables
    
    private let avatarImgView = UIImageView()
    
    private let nameLabel = UILabel().then {
        $0.font = .poppinsRegularFont(size: 14)
        $0.textColor = .draculaOrchid
        $0.numberOfLines = 0
    }
    
    // MARK: - Public Variables
    
    var setData: GithubUserModel? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Override Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        self.contentView.addSubviews(avatarImgView, nameLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        avatarImgView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImgView.snp.trailing).offset(12)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
    
    private func updateUI() {
        guard let data = setData else {
            return
        }
        avatarImgView.setImage(url: data.avatarURL)
        nameLabel.text = data.login
    }
}

