//
//  MangaCollectionViewCell.swift
//  mangaque
//
//  Created by Artyom Raykh on 11.08.2022.
//

import Kingfisher

final class MangaCollectionViewCell: UICollectionViewCell {
        
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var mangaItem: MangaViewData? {
        didSet {
            configureCell()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        addSubview(titleLabel)
        addSubview(coverImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        coverImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).inset(-10)
        }
        
        coverImageView.layer.cornerRadius = 10
        coverImageView.clipsToBounds = true
        
        coverImageView.contentMode = .scaleAspectFill
        
        titleLabel.numberOfLines = 0
        
        backgroundColor = .lightGray.withAlphaComponent(0.05)
        layer.cornerRadius = 10
        
    }
    
    func configureCell() {
        
        guard let mangaItem = mangaItem else {
            return
        }
        titleLabel.text = mangaItem.title
        coverImageView.kf.setImage(with: mangaItem.coverURL)
    }
}
